class StockProductDestinationsController < ApplicationController
    def create
        warehouse = Warehouse.find(params[:warehouse_id])
        product = ProductModel.find(params[:product_model_id])

        stock = StockProduct.find_by(warehouse: warehouse, product_model: product)
        if stock != nil
            stock.create_stock_product_destination!(
                address: params[:address], recipient: params[:recipient]
            )
            return redirect_to warehouse, notice: 'Item retirado com sucesso'
        end
    end
end