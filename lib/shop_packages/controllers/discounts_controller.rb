module ShopPackages
  module Controllers
    module DiscountsController
      
      def self.included(base)
        base.class_eval do
          
          def config_edit_with_packages
            config_edit_without_packages
            
            @buttons  << 'browse_packages'
            @parts    << 'packages'
            @popups   << 'browse_packages'
          end
          alias_method_chain :config_edit, :packages
          
        end
      end
      
    end
  end
end