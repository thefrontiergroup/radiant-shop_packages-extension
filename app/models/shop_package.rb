class ShopPackage < ActiveRecord::Base
  
  belongs_to  :created_by,  :class_name => 'User'
  belongs_to  :updated_by,  :class_name => 'User'
  
  has_many    :packings,    :class_name => 'ShopPacking',   :foreign_key  => :package_id, :dependent => :destroy
  has_many    :products,    :class_name => 'ShopProduct',   :foreign_key  => :product_id, :through => :packings
  has_many    :line_items,  :class_name => 'ShopLineItem',  :as => :item
  has_many    :orders,      :class_name => 'ShopOrder',     :through => :line_items
  
  before_validation         :assign_sku
  
  validates_presence_of     :name, :sku
  
  validates_uniqueness_of   :name, :sku
  
  validates_numericality_of :price, :greater_than => 0.00, :allow_nil => true, :precisions => 2
  
  # Returns the products not attached to the category
  def available_products; ShopProduct.all - self.products; end
  
  # Returns the slug of the first product
  def slug; packings.first.product.slug; end
  
  # Returns the url of the first product
  def url; packings.first.product.url; end
  
  # Not a valid option, but useful incase a tag is called
  def category; nil; end

  # Overloads the base to_json to return what we want
  def to_json(*attrs); super self.class.params; end
  
  # Returns the aggregate value of the products in the package
  def value
    value = 0
    self.packings.map { |pkg| value += (pkg.product.price.to_f * pkg.quantity) }
    value
  end
  
  # Returns the aggregate weight of the products in the package
  def weight
    weight = 0
    self.packings.map { |pkg| weight += (pkg.product.weight.to_f * pkg.quantity) }
    weight
  end
  
  class << self
    
    # Returns attributes attached to the product
    def attrs
      [ :id, :name, :price, :sku, :description, :created_at, :updated_at ]
    end
    
    # Returns methods with usefuly information
    def methds
      []
    end
    
    # Returns the objects to include
    def inclde
      [ :category, :products ]
    end
    
    # Returns a custom hash of attributes on the product
    def params
      { :only  => self.attrs, :methods => self.methds, :include => self.inclde }
    end
    
  end
    
private

  # Assigns an sku based off the name
  def assign_sku
    self.sku = ShopProduct.to_sku(sku.present? ? sku : name)
  end
  
end