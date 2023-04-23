class Warehouse < ApplicationRecord
    validates :name, :code, :city, :area, :zip, :address, 
    :description, presence: true
end
