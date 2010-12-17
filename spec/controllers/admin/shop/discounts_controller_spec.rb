require "#{File.dirname(__FILE__)}/../../../spec_helper"

describe Admin::Shop::DiscountsController do
  
  dataset :users, :shop_discounts
  
  before :each do
    login_as users(:admin)
  end
  
  it 'should assign packages to the #edit method' do
    get :edit, :id => shop_discounts(:ten_percent).id
    
    assigns(:buttons).include?('browse_packages').should be_true
    assigns(:parts).include?('packages').should be_true
    assigns(:popups).include?('browse_packages').should be_true
  end
  
  it 'should assign packages to the #edit method' do
    put :update, :id => shop_discounts(:ten_percent).id
    
    assigns(:buttons).include?('browse_packages').should be_true
    assigns(:parts).include?('packages').should be_true
    assigns(:popups).include?('browse_packages').should be_true
  end
  
end