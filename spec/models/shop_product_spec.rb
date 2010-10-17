require 'spec/spec_helper'

describe ShopProduct do
  dataset :shop_products, :shop_packages
  
  describe 'relationships' do
    before :each do
      @product = shop_products(:crusty_bread)
    end

    it 'should have many packings' do
      @product.packings.is_a?(Array).should be_true
    end

    it 'should have many packages' do
      @product.packages.is_a?(Array).should be_true
    end
  end
  
end