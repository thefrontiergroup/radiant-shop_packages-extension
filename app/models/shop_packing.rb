class ShopPacking < ActiveRecord::Base
  
  default_scope :order => 'shop_packings.position ASC'
  
  belongs_to :package, :class_name => 'ShopPackage', :foreign_key => :package_id
  belongs_to :product, :class_name => 'ShopProduct', :foreign_key => :product_id
  
  before_validation :set_quantity
  
  validates_uniqueness_of :product_id, :scope => :package_id
  
  def value
    self.product.price.to_f * self.quantity
  end
  
private

  def set_quantity
    self.quantity = [1,self.quantity].max
  end
  
end