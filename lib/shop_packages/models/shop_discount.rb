module ShopPackages
  module Models
    module ShopDiscount
      
      def self.included(base)
        base.class_eval do
          
          has_many :packages, :through => :discountables, :source => :package, :conditions => "shop_discountables.discounted_type = 'ShopPackage'"
          
          def available_packages
            ShopPackage.all - packages
          end
          
        end
      end
      
    end
  end
end