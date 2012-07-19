class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :truck
  
  accepts_nested_attributes_for :product
  attr_accessible :note, :product_id, :quantity, :product_id, :truck_id
  
  after_initialize :after_init
  
  def product_attributes=(attributes)
    p = Product.find_by_make_and_model attributes[:make], attributes[:model]
    if p.nil?
      build_product
      self.product.attributes = attributes
    else
      self.product = p
    end
  end
  
  protected
  
  def after_init
    build_product if product.nil?
  end

end
