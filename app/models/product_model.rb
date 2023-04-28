class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name,:weight,:height,:width,
  :depth,:sku, presence: true
  validates :sku, length:{is:20}
  validates :sku, uniqueness: true
  validates :weight,:height,
  :width,:depth, numericality: {greater_than_or_equal_to: 0}

end
