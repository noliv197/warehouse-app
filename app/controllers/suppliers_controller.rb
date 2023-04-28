class SuppliersController < ApplicationController
    before_action :get_supplier, only: [:show,:edit,:update] 
    def show ; end
    def edit ; end
    
    def index
        @suppliers = Supplier.all
    end

    def new
        @supplier = Supplier.new
    end

    def create
        @supplier = Supplier.new(supplier_params)
        if @supplier.save
            return redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
        end
        flash.now[:notice] = 'Não foi possível cadastrar fornecedor'
        render :new, status: 422
    end

    def update
        if @supplier.update(supplier_params)
            return redirect_to supplier_path(@supplier), notice: 'Fornecedor atualizado com sucesso'
        end
        flash.now[:notice] = 'Não foi possivel salvar as alterações'
        render :new, status: 422
    end

    private
    def get_supplier
        @supplier = Supplier.find(params[:id])
    end
    def supplier_params
        params.require(:supplier).permit(
            :corporate_name,:brand_name,:cnpj,:registration_number,
            :full_address,:city,:state,:email,:phone
        )
    end
end