require 'spec/spec_helper'

describe ShopPacking do
  
  dataset :shop_packages
  
  before(:each) do
    @packing  = shop_packings(:warm_bread)
  end
  
  describe 'attributes' do
    
    it 'should have a quantity' do
      @packing.quantity.should == 1
    end
    
    it 'should have a position' do
      @packing.position.should == 1
    end
    
    it 'should have a package' do
      @packing.package.class.should == ShopPackage
    end
    
    it 'should have a product' do
      @packing.product.class.should == ShopProduct
    end
    
  end
  
  context 'instance methods' do
  
    describe '#value' do
    
      it 'should return the quantity multiplied by the product price' do
        @packing.value.should === @packing.quantity * @packing.product.price.to_f
      end
    
    end
    
  end
  
  context 'Class Methods' do
    
    describe '#set_quantity' do
      it 'should return the highest of 1 or the quantity' do
        @packing.quantity = 0
        @packing.save
        @packing.quantity.should === 1
        
        @packing.quantity = 1
        @packing.save
        @packing.quantity.should === 1
        
        @packing.quantity = -1
        @packing.save
        @packing.quantity.should === 1
        
        @packing.quantity = 2
        @packing.save
        @packing.quantity.should === 2
      end
    end
    
  end
  
end