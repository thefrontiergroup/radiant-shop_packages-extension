# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ShopPackagesExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shop_packages"
  
  extension_config do |config|
    config.after_initialize do
      #
    end
  end

  def activate
    
    UserActionObserver.instance.send :add_observer!, ShopPackage
    
    unless defined? admin.packages
      Radiant::AdminUI.send :include, ShopPackages::Interface::Packages
      
      admin.packages = Radiant::AdminUI.load_default_shop_packages_regions
    end
    
    ShopProduct.send :include, ShopPackages::Models::ShopPackageable
    
  end
end
