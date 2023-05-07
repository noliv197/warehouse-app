class OrderItemsController < ApplicationController
    def new
        @order = Order.find(params[:order_id])
        @order_item = OrderItem.new
        @products = @order.supplier.product_models
    end
    def create 
        @order = Order.find(params[:order_id])
        order_item_params = params.require(:order_item).permit(
            :product_model_id,:quantity
        )
        @order_item = OrderItem.new(order_item_params)
        @order_item.order = @order
        if @order_item.save
            return redirect_to @order, notice: 'Item adicionado com sucesso'
        else
            @products = @order.supplier.product_models
            flash.now[:notice] = 'Não foi possivel adicionar o item'
            render :new, status: 422
        end
    end
end