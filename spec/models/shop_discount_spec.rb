require File.dirname(__FILE__) + "/../spec_helper"

describe ShopDiscount do
  
  dataset :shop_packages, :shop_discounts
  
  it 'should have many #packages' do
    shop_discounts(:ten_percent).packages.is_a?(Array).should be_true
  end
  
  it 'should return a subset through #available_attributes' do
    shop_discounts(:ten_percent).available_packages.should have(ShopPackage.all.count).packages
    shop_discounts(:ten_percent).discountables.create(:discounted_id => shop_packages(:all_bread).id, :discounted_type => shop_packages(:all_bread).class.name)
    shop_discounts(:ten_percent).available_packages.should have(ShopPackage.all.count-1).packages
  end
  
end