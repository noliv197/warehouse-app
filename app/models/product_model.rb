class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  
  validates :name,:weight,:height,:width,
  :depth,:sku, presence: true
  validates :sku, length:{is:20}
  validates :sku, uniqueness: true
  validates :weight,:height,
  :width,:depth, numericality: {greater_than_or_equal_to: 0}

  def dimensions
    "#{height}cm x #{width}cm x #{depth}cm"
  end
end
