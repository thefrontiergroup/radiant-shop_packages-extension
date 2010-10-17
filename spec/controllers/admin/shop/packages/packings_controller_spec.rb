require 'spec/spec_helper'

describe Admin::Shop::Packages::PackingsController do
  
  dataset :users
    
  before(:each) do
    login_as  :admin
    
    @shop_package   = ShopPackage.new
    @shop_packages  = [ @shop_package ]
    
    @shop_product   = ShopProduct.new
    @shop_products  = [ @shop_product ]
    
    @shop_packing   = ShopPacking.new
    @shop_packings  = [ @shop_packing ]
    
    stub(@shop_package).id { 1 }
    stub(@shop_package).packings { @shop_packings }
  end
  
  describe '#sort' do
    before :each do
      @packings = [
        'package_products[]=2',
        'package_products[]=1'
      ].join('&')
    end
    
    context 'packings are not passed' do      
      context 'js' do
        it 'should return an error string and failure status' do
          put :sort, :package_id => 1, :format => 'js'
          
          response.should_not be_success
          response.body.should === "Could not sort products."
        end
      end
    end
    
    context 'categories are passed' do
      context 'could not sort' do
        before :each do
          mock(ShopPacking).find('2').stub!.update_attributes!({:position,1}) { raise ActiveRecord::RecordNotSaved }
        end
        
        context 'js' do
          it 'should return an error string and failure status' do
            put :sort, :package_id => 1, :packings => @packings, :format => 'js'
            
            response.should_not be_success
            response.body.should === 'Could not sort products.'
          end
        end
      end
      
      context 'successfully sorted' do
        before :each do
          mock(ShopPacking).find('2').stub!.update_attributes!({:position,1}) { true }
          mock(ShopPacking).find('1').stub!.update_attributes!({:position,2}) { true }
        end
        
        context 'js' do
          it 'should return success string and success status' do
            put :sort, :package_id => 1, :packings => @packings, :format => 'js'
            
            response.should be_success
            response.body.should === 'Products successfully sorted.'
          end
        end
      end
    end
  end
  
  describe '#create' do
    before :each do
      mock(ShopPackage).find('1') { @shop_package }
      mock(ShopProduct).find('1') { @shop_product }
      mock(ShopPacking).new       { @shop_packing }
    end
    context 'packing could not be created' do
      before :each do
        mock(@shop_packing).save! { raise ActiveRecord::RecordNotSaved }
      end
      
      context 'js' do
        it 'should return error notice and failure status' do
          post :create, :package_id => 1, :product_id => 1, :format => 'js'
          
          response.body.should === 'Could not attach product.'
          response.should_not be_success
        end
      end
    end

    context 'packing successfully created' do
      before :each do
        mock(@shop_packing).save! { true }
      end
      
      context 'js' do
        it 'should render the collection partial and success status' do
          post :create, :package_id => 1, :product_id => 1, :format => 'js'

          response.should be_success
          assigns(:shop_packing).should === @shop_packing
          response.should render_template('admin/shop/packages/edit/shared/_product')
        end
      end
    end
  end
  
  describe '#update' do
    before :each do
      mock(ShopPacking).find('1') { @shop_packing }
    end
    context 'packing could not be created' do
      before :each do
        mock(@shop_packing).update_attributes!({ :quantity => '1' }) { raise ActiveRecord::RecordNotSaved }
      end
      
      context 'js' do
        it 'should return error notice and failure status' do
          put :update, :package_id => 1, :id => 1, :quantity => 1, :format => 'js'
          
          response.should_not be_success
          response.body.should === 'Could not update Product Quantity.'
        end
      end
    end
    
    context 'packing successfully created' do
      before :each do
        mock(@shop_packing).update_attributes!({ :quantity => '1' }) { true }
      end
      
      context 'js' do
        it 'should render the collection partial and success status' do
          put :update, :package_id => 1, :id => 1, :quantity => 1, :format => 'js'
          
          response.should be_success
          response.body.should === 'Product Quantity successfully updated.'
          
        end
      end
    end
  end

  describe '#destroy' do
    before :each do
      mock(ShopPacking).find('1') { @shop_packing }
      stub(@shop_packing).product { nil }
      stub(@shop_packing).package { nil }
    end
    
    context 'product not destroyed' do
      before :each do
        stub(@shop_packing).destroy { raise ActiveRecord::RecordNotFound }
      end
      
      context 'js' do
        it 'should render an error and failure status' do
          delete :destroy, :package_id => 1, :id => 1, :format => 'js'
          
          response.should_not be_success
          response.body.should === 'Could not remove product.'
        end
      end
    end
    
    context 'product successfully destroyed' do
      before :each do
        stub(@shop_packing).destroy { true }
      end
      
      context 'js' do
        it 'should render success message and success status' do
          delete :destroy, :package_id => 1, :id => 1, :format => 'js'
          
          response.should be_success
          response.should render_template('admin/shop/packages/edit/shared/_product')
        end
      end
    end
  end
  
end
