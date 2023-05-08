class Warehouse < ApplicationRecord
    has_many :stock_products

    validates :name, :code, :city, :area, :zip, :address, 
    :description, presence: true
    validates :code, length: {is:3}
    validates :code, uniqueness: true
    validates :name, uniqueness: true

    def full_description
        "#{code} | #{name}"
    end
end
