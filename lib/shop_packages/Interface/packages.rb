module ShopPackages
  module Interface
    module Packages
      
      def self.included(base)
        base.send :include, InstanceMethods
      end
      
      module InstanceMethods
        attr_accessor :packages
        
        protected

        def load_default_shop_packages_regions
          returning OpenStruct.new do |packages|
            packages.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{head form popups}
              edit.form.concat %w{inputs meta parts foot}
              edit.foot.concat %w{buttons timestamp}
            end
            packages.new = packages.edit
            packages.index = Radiant::AdminUI::RegionSet.new do |index|
              index.head.concat %w{}
              index.body.concat %w{name modify}
              index.foot.concat %w{buttons}
            end
            packages.remove = packages.index
          end
        end
      end
      
    end
  end
end