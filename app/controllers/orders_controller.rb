class OrdersController < ApplicationController
    before_action :get_order, only:[:show]
    def show; end
    def new
        @order = Order.new
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end
    def create
        @order = Order.new(order_params)
        @order.user = current_user
        if @order.save
            return redirect_to @order, notice: 'Pedido registrado com sucesso'
        else
            @warehouses = Warehouse.all
            @suppliers = Supplier.all
            flash.now[:notice] = 'Não foi possivel completar a operação'
            render :new, status: 422
        end
    end

    private
    def get_order
        @order = Order.find(params[:id])
    end
    def order_params
        params.require(:order).permit(
            :warehouse_id,:supplier_id,
            :user_id,:estimated_delivery_date
        )
    end
end