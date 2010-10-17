module ShopPackages
  module Models
    module ShopPackageable
      
      def self.included(base)
        base.class_eval do
          has_many :packings, :class_name => 'ShopPacking', :foreign_key => :product_id
          has_many :packages, :class_name => 'ShopPackage', :foreign_key => :package_id, :through => :packings, :source => :package
          has_many :related,  :class_name => 'ShopProduct', :through     => :packings,   :source  => :product,  :uniq   => true
        end
      end
      
    end
  end
end