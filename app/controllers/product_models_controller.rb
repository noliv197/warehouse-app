class ProductModelsController < ApplicationController
    before_action :get_product_model, only:[:show]
    def show; end
    def index
        @product_models = ProductModel.all
    end
    def new
        @product_model = ProductModel.new
        @suppliers = Supplier.all
    end
    def create
        @product_model = ProductModel.new(product_model_params)
        if @product_model.save
            return redirect_to product_models_path, notice: 'Produto cadastrado com sucesso'
        else
            @suppliers = Supplier.all
            flash.now[:notice] = 'Não foi possível cadastrar produto'
            render :new, status: 422
        end
    end

    private 
    def get_product_model
        @product_model = ProductModel.find(params[:id])
    end
    def product_model_params
        params.require(:product_model).permit(
            :name,:weight,:height,:width,
            :depth,:sku,:supplier_id)
    end
end