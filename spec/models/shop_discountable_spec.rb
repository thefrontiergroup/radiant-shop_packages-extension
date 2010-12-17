require "#{File.dirname(__FILE__)}/../spec_helper"

describe ShopDiscountable do
  
  dataset :shop_packages, :shop_discounts
  
  it 'should have a #package' do
    @discountable = ShopDiscountable.new
    @discountable.package = shop_packages(:all_bread)
    @discountable.package.is_a?(ShopPackage).should be_true
  end
  
end