class ShopPackagesDataset < Dataset::Base
  
  uses :shop_products

  def load
    packages = {
      :bread  => [ :soft, :crusty, :warm ]
    }
    
    packages.each do |package, products|
      create_record :shop_package, "all_#{package.to_s}".to_sym,
        :name     => "all #{package.to_s}",
        :sku      => "all_#{package.to_s}",
        :price    => 1 * 10
      products.each_with_index do |product, i|
        create_record :shop_packing, "#{product.to_s}_bread".to_s.to_sym,
          :quantity => 1,
          :position => 1,
          :package  => shop_packages("all_#{package.to_s}".to_sym),
          :product  => shop_products("#{product.to_s}_bread".to_sym)
      end
    end
  end
  
end
