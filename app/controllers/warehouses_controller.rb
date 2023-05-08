class WarehousesController < ApplicationController
    before_action :get_warehouse, only: [:show,:edit,:update,:destroy] 
    def edit; end
    def show
        @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
        @product_models = ProductModel.all
    end
    def new
        @warehouse = Warehouse.new
    end
    def create
        @warehouse = Warehouse.new(warehouse_params)
        if @warehouse.save 
            return redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
        end
        flash.now[:notice] = 'Galpão não cadastrado'
        render :new, status: 422
    end
    def update
        if @warehouse.update(warehouse_params)
            return redirect_to warehouse_path(@warehouse), notice: 'Galpão alterado com sucesso'
        end
        flash.now[:notice] = 'Não foi possivel salvar as alterações'
        render :edit, status: 422
    end
    def destroy
        if @warehouse.destroy
            return redirect_to root_path, notice: 'Galpão deletado com sucesso'
        end
        flash.now[:notice] = 'Não foi possível remover o galpão'
        render :edit, status: 422
    end

    private
    def get_warehouse 
        @warehouse = Warehouse.find(params[:id])
    end
    def warehouse_params
        params.require(:warehouse).permit(
            :name,:code,:city,:area,:address,:zip,:description
        )
    end
end