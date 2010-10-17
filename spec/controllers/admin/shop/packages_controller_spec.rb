require 'spec/spec_helper'

describe Admin::Shop::PackagesController do
  
  dataset :users, :shop_packages
    
  before(:each) do
    login_as  :admin
    @package = shop_packages(:all_bread)
  end
  
  describe '#new' do
    it 'should assign global instance variables' do
      get :new
      
      assigns(:meta).should     === ['sku']
      assigns(:buttons).should  === []
      assigns(:parts).should    === ['description']
    end
  end
  
  describe '#edit' do
    it 'should assign global instance variables' do
      get :edit, :id => @package.id
      
      assigns(:meta).should     === ['sku']
      assigns(:buttons).should  === ['browse_products']
      assigns(:parts).should    === ['description','products']
    end
  end
  
end