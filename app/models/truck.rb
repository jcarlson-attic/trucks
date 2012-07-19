class Truck < ActiveRecord::Base
  has_many :line_items
  attr_accessible :name, :region
end
