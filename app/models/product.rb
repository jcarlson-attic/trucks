class Product < ActiveRecord::Base
  attr_accessible :description, :make, :model
end
