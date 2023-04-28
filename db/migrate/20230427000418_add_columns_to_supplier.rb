class AddColumnsToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :cnpj, :string
    add_column :suppliers, :phone, :string
  end
end
