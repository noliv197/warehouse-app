class Supplier < ApplicationRecord
    has_many :product_models

    validates :corporate_name,:brand_name,:cnpj,
    :email, presence: true
    validates :cnpj, uniqueness: true
    validates :cnpj, length: {is:13}
    validates :cnpj, numericality: { only_integer: true }
end
