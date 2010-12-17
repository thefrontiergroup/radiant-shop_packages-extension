module ShopPackages
  module Models
    module ShopDiscountable
      
      def self.included(base)
        base.class_eval do
          
          
          belongs_to :package, :class_name => 'ShopPackage', :foreign_key => :discounted_id
          
        end
      end
      
    end
  end
end