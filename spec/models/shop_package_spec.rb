require 'spec/spec_helper'

describe ShopPackage do
  
  dataset :shop_packages
  
  before(:each) do
    @package  = shop_packages(:all_bread)
  end
  
  describe 'attributes' do
    
    it 'should have a name' do
      @package.name.should == 'all bread'
    end
    
    it 'should have a price' do
      @package.price.should === 10.00
    end
    
  end
  
  describe 'validation' do
    
    it 'should require a name' do
      @package = ShopPackage.new
      
      @package.valid? === false
      
      @package.name   = "name"
      @package.valid? === true
    end
    
    it 'should validate but not require the price' do
      @package = ShopPackage.new({ :name => 'name' })
      @package.valid? === true
      
      @package.price  = "asdas"
      @package.valid? === false
      
      @package.price  = "-999.99"
      @package.valid? === false
      
      @package.price  = "9.99.99"
      @package.valid? === false
      
      @package.price  = "0.00"
      @package.valid? === false
      
      @package.price  = "0.01"
      @package.valid? === true
      
      @package.price  = "999999.99"
      @package.valid? === true
    end
    
    it 'should generate a valid sku on validation' do
      @package = ShopPackage.new({ :name => "dark_ _:_;_=_+_._~_toasted" })
      
      @package.valid?     === true
      @package.sku.should === 'dark_______________toasted'
    end
    
    it 'should have an array of products' do
      @package.products.class.should == Array
    end
    
    it 'should have an array of line_items' do
      @package.line_items.class.should == Array
    end
    
    it 'should have an array of orders' do
      @package.orders.class.should == Array
    end
    
  end
  
  context 'instance methods' do
    
    describe '#value' do
      it 'should return the total value of its products' do
        value = 0
        @package.packings.map { |pkg| value += (pkg.product.price.to_f * pkg.quantity) }
        
        @package.value.should === value
      end
    end
    
    describe '#weight' do
      it 'should return the total value of its products' do
        weight = 0
        @package.packings.map { |pkg| weight += (pkg.product.weight.to_f * pkg.quantity) }
        
        @package.weight.should === weight
      end
    end
    
    describe '#available_products' do
      it 'should return the subset of products not in that package' do
        @package.available_products.should === (ShopProduct.all - @package.products)
      end
    end
    
  end
  
  
  context 'Class Methods' do
    
    describe '#params' do
      it 'should have a set of standard parameters' do
        ShopPackage.attrs.should === [ :id, :name,:price, :sku, :description, :created_at, :updated_at ]
      end
    end
    
  end
  
end