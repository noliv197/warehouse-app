class OrdersController < ApplicationController
    before_action :get_order_and_check_user, only:[:show,:edit,:update,:delivered,:canceled]
    def index
        @orders = current_user.orders
    end
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
    def edit
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end
    def update
        if @order.update(order_params)
            return redirect_to order_path(@order), notice: 'Atualizações feitas com sucesso'
        else
            @warehouses = Warehouse.all
            @suppliers = Supplier.all
            flash.now[:notice] = 'Não foi possivel salvar as alterações'
            render :new, status: 422
        end
    end
    def search
        @code = params["query"]
        @orders = Order.where("code LIKE ? AND user_id = ?", "%#{@code}%",current_user)
        if @orders.length == 1 && @orders[0].code === @code
            return redirect_to @orders[0]
        end
    end
    def delivered
        @order.delivered!
        return redirect_to @order
    end
    def canceled
        @order.canceled!
        return redirect_to @order
    end

    private
    def get_order_and_check_user
        @order = Order.find(params[:id])
        if @order.user != current_user
            return redirect_to root_path, notice: 'Você não tem permissão para executar essa ação'
        end
    end
    def order_params
        params.require(:order).permit(
            :warehouse_id,:supplier_id,
            :user_id,:estimated_delivery_date
        )
    end
end