class LineItem < ActiveRecord::Base
  attr_accessible :note, :product_id, :quantity
end
