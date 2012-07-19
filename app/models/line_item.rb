class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :truck
  
  accepts_nested_attributes_for :product
  attr_accessible :note, :product_id, :quantity, :product_id, :truck_id
  
  delegate :make, :model, :description, :to => :product
  
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
                            :product_attributes => {:make => make, :model => model, :description => desc}, 
                            :unit_price => uprice.gsub(/[\$,]/,''), 
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
  
  def total_price
    quantity * unit_price
  end
  
  protected
  
  def after_init
    build_product if product.nil?
  end

end
