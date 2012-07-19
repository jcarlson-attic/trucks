class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :truck
  
  accepts_nested_attributes_for :product
  accepts_nested_attributes_for :truck
  attr_accessible :note, :product_id, :quantity, :product_id, :product_attributes, :truck_id, :truck_attributes
  
  delegate :make, :model, :description, :unit_price, :to => :product
  
  after_initialize :after_init
  
  def self.import(file_path)
    file = File.open(file_path, "r")
    count = 0
    while (text = file.gets)
      
      # trim line
      text = text.chomp
      
      # split line into columns
      qty, make, model, desc, uprice, truck, note = text.split "\t"
      
      # create LineItem
      li = LineItem.create  :quantity => qty, 
                            :product_attributes => {:make => make, :model => model, :description => desc, :unit_price => uprice.gsub(/[\$,]/,'')}, 
                            :truck_attributes => {:name => truck},
                            :note => note
      count += 1
    end
    count
  end
  
  def product_attributes=(attributes)
    p = Product.find_by_make_and_model attributes[:make], attributes[:model]
    if p.nil?
      build_product
      self.product.attributes = attributes
    else
      self.product = p
    end
  end
  
  def truck_attributes=(attributes)
    t = Truck.find_by_name attributes[:name]
    if t.nil?
      build_truck
      self.truck.attributes = attributes
    else
      self.truck = t
    end
  end
  
  def total_price
    quantity * unit_price unless quantity.nil? or unit_price.nil?
  end
  
  protected
  
  def after_init
    build_product if product.nil?
  end

end
