module ShopPackages
  module Tags
    class Helpers
      class << self
        include ActionView::Helpers::NumberHelper
          
        def current_packages(tag)
          result = nil
          
          if tag.locals.shop_product.present?
            result = tag.locals.shop_product.packages
          
          elsif tag.attr['key'] and tag.attr['value']
            result = ShopPackage.all(:conditions => { tag.attr['key'].downcase.to_sym => tag.attr['value']})
          
          else
            result = ShopPackage.all
          
          end
          
          result
        end
        
        def current_package(tag)
          result = nil
          
          if tag.locals.shop_package.present?
            result = tag.locals.shop_package
          
          elsif tag.attr['key'] and tag.attr['value']
            result = ShopPackage.first(:conditions => { tag.attr['key'].downcase.to_sym => tag.attr['value']})
            
          end
          
          result
        end
        
      end
    end
  end
end