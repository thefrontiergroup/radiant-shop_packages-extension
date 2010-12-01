class ShopPackagesExtension < Radiant::Extension
  version YAML::load_file(File.join(File.dirname(__FILE__), 'VERSION'))
  description "Group up Products into packages, you can assign a price to a package"
  url "https://github.com/thefrontiergroup/radiant-shop_packages-extension/"
  
  extension_config do |config|
    config.after_initialize do
      config.gem 'radiant-shop-extension'
    end
  end
  
  UserActionObserver.instance.send :add_observer!, ShopPackage
  
  def activate
    
    tab "Shop" do
      add_item "Packages", "/admin/shop/packages", :before => "Orders"
    end
    
    unless defined? admin.packages
      Radiant::AdminUI.send :include, ShopPackages::Interface::Packages
      
      admin.packages = Radiant::AdminUI.load_default_shop_packages_regions
    end
    
    ShopProduct.send :include, ShopPackages::Models::ShopPackageable
    Page.send        :include, ShopPackages::Tags::Package
    
    if Radiant::Extension.descendants.any? { |extension| extension.extension_name == 'ShopDiscounts' }
      ShopPackage.send  :include, ShopDiscounts::Models::Discountable
    end
    
  end
end
