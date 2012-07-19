class Product < ActiveRecord::Base
  has_many :line_items
  attr_accessible :description, :make, :model, :unit_price
  
  def quantity
    line_items.sum :quantity
  end
  
  def total_price
    quantity * unit_price
  end
  
end
