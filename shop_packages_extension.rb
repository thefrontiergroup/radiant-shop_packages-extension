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
    
    if defined?(ShopDiscount)
      ShopPackage.send                      :include, ShopDiscounts::Models::Discountable
      Admin::Shop::DiscountsController.send :include, ShopPackages::Controllers::DiscountsController
      ShopDiscount.send                     :include, ShopPackages::Models::ShopDiscount
      ShopDiscountable.send                 :include, ShopPackages::Models::ShopDiscountable
    end
    
  end
end
