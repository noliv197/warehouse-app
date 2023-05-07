class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order

  validates :quantity, presence: true

  def description
    "#{quantity} x #{product_model.name}"
  end
end
