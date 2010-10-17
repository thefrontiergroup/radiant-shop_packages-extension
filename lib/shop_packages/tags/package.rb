module Shop
  module Tags
    module Package
      include Radiant::Taggable
      include ActionView::Helpers::NumberHelper
      
      tag 'shop:packages' do |tag|
        tag.locals.shop_packages = Helpers.current_packages(tag)
        tag.expand
      end
      
      desc %{ expands if there are packages within the context }
      tag 'shop:packages:if_packages' do |tag|
        tag.expand if tag.locals.shop_packages.present?
      end
      
      desc %{ expands if there are no packages within the context }
      tag 'shop:packages:unless_packages' do |tag|
        tag.expand unless tag.locals.shop_packages.present?
      end
      
      desc %{ iterates through each package within the scope }
      tag 'shop:packages:each' do |tag|
        content   = ''
        
        tag.locals.shop_packages.each do |package|
          tag.locals.shop_package = package
          content << tag.expand
        end
        
        content
      end
      
      tag 'shop:package' do |tag|
        tag.locals.shop_package = Helpers.current_package(tag)
        tag.expand unless tag.locals.shop_package.nil?
      end
      
      [:id, :name, :sku].each do |symbol|
        desc %{ outputs the #{symbol} of the current package }
        tag "shop:package:#{symbol}" do |tag|
          tag.locals.shop_package.send(symbol)
        end
      end
      
      desc %{ outputs the description of the current packaage}
      tag "shop:package:description" do |tag|
        parse(TextileFilter.filter(tag.locals.shop_package.description))
      end
      
      [:price, :value].each do |symbol|
        desc %{ output #{symbol} of product }
        tag "shop:package:#{symbol}" do |tag|
          attr    = tag.attr.symbolize_keys
          package = tag.locals.shop_package
          
          Helpers.currency(package.send(symbol),attr)
        end
      end
      
      desc %{ expands if the package has products }
      tag 'shop:package:if_products' do |tag|
        tag.expand unless tag.locals.shop_package.products.empty?
      end
      
      desc %{ expands if the package do not have products }
      tag 'shop:package:unless_products' do |tag|
        tag.expand if tag.locals.shop_package.products.empty?
      end
      
      tag 'shop:package:products' do |tag|
        tag.expand
      end
      
      desc %{ iterates through each of the products images }
      tag 'shop:package:products:each' do |tag|
        content = ''
        
        tag.locals.shop_package.packings.each do |packing|
          tag.locals.shop_product = packing.product
          tag.locals.shop_packing = packing
          content << tag.expand
        end
        
        content
      end
      
      desc %{ outputs the quantity of the current packing }
      tag 'shop:package:product:quantity' do |tag|
        tag.locals.shop_packing.quantity
      end
      
    end
  end
end