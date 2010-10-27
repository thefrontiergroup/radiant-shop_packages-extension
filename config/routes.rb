ActionController::Routing::Routes.draw do |map|
  
  map.namespace :admin do |admin|
    admin.namespace :shop, :member => { :remove => :get } do |shop|
      
      shop.resources :packages, :member => { :remove => :get } do |packages|
        packages.resources :packings,         :controller => 'packages/packings',           :only => [:create, :update, :destroy],  :collection => { :sort => :put }
      end
      
    end
  end
  
end