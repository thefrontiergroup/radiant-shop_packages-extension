require 'spec/spec_helper'

describe ShopPackages::Tags::Package do
  
  dataset :pages, :shop_packages
  
  it 'should describe these tags' do
    ShopPackages::Tags::Package.tags.sort.should == [
      'shop:packages',
      'shop:packages:if_packages',
      'shop:packages:unless_packages',
      'shop:packages:each',
      'shop:package',
      'shop:package:id',
      'shop:package:name',
      'shop:package:sku',
      'shop:package:description',
      'shop:package:price',
      'shop:package:value',
      'shop:package:if_products',
      'shop:package:unless_products',
      'shop:package:products',
      'shop:package:products:each',
      'shop:package:product:quantity'].sort
  end
  
  before :all do
    @page = pages(:home)
  end
  
  before :each do
    @package = shop_packages(:all_bread)
  end
  
  context 'outside a package' do
    describe '<r:shop:packages>' do
      context 'packages' do
        it 'should render' do
          tag = %{<r:shop:packages>success</r:shop:packages>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end
      context 'no packages' do
        it 'should render' do
          tag = %{<r:shop:packages>success</r:shop:packages>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:packages:if_packages>' do
      context 'success' do
        it 'should render' do
          tag = %{<r:shop:packages:if_packages>success</r:shop:packages:if_packages>}
          exp = %{success}
          
          @page.should render(tag).as(exp)
        end
      end
      context 'failure' do
        it 'should render' do
          mock(ShopPackages::Tags::Helpers).current_packages(anything) { [] }
          tag = %{<r:shop:packages:if_packages>failure</r:shop:packages:if_packages>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:packages:unless_packages>' do
      context 'success' do
        it 'should not render' do
          mock(ShopPackages::Tags::Helpers).current_packages(anything) { [] }
          
          tag = %{<r:shop:packages:unless_packages>success</r:shop:packages:unless_packages>}
          exp = %{success}
          
          @page.should render(tag).as(exp)
        end
      end
      context 'failure' do
        it 'should render' do
          mock(ShopPackages::Tags::Helpers).current_packages(anything) { ShopPackage.all }
        
          tag = %{<r:shop:packages:unless_packages>failure</r:shop:packages:unless_packages>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:packages:each>' do
      context 'success' do
        it 'should render' do
          mock(ShopPackages::Tags::Helpers).current_packages(anything) { ShopPackage.all }
          
          tag = %{<r:shop:packages:each>.a.</r:shop:packages:each>}
          exp = ShopPackage.all.map{ '.a.' }.join('')
          
          @page.should render(tag).as(exp)
        end
      end
      
      context 'failure' do
        it 'should not render' do
          mock(ShopPackages::Tags::Helpers).current_packages(anything) { [] }
          
          tag = %{<r:shop:packages:each>failure</r:shop:packages:each>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:package>' do
      context 'success' do
        it 'should render' do
          mock(ShopPackages::Tags::Helpers).current_package(anything) { @package }
          
          tag = %{<r:shop:package>success</r:shop:package>}
          exp = %{success}
          
          @page.should render(tag).as(exp)
        end
      end
      
      context 'failure' do
        it 'should not render' do
          mock(ShopPackages::Tags::Helpers).current_package(anything) { nil }
          
          tag = %{<r:shop:package>failure</r:shop:package>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
  end
  
  context 'within a package' do
    
    before :each do
      mock(ShopPackages::Tags::Helpers).current_package(anything) { @package }
    end
    
    context 'simple attributes' do
      describe '<r:shop:package:id />' do
        it 'should render the id' do
          tag = %{<r:shop:package:id />}
          exp = @package.id.to_s
          
          @page.should render(tag).as(exp)
        end
      end
      
      describe '<r:shop:package:name />' do
        it 'should render the name' do
          tag = %{<r:shop:package:name />}
          exp = @package.name.to_s
          
          @page.should render(tag).as(exp)
        end
      end
      
      describe '<r:shop:package:sku />' do
        it 'should render the sku' do
          tag = %{<r:shop:package:sku />}
          exp = @package.sku.to_s
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:package:description />' do
      it 'should render a textile filtered result' do
        @package.description = '*bold*'
        
        tag = %{<r:shop:package:description />}
        exp = %{<p><strong>bold</strong></p>}
        
        @page.should render(tag).as(exp)
      end
    end
    
    context 'currency attributes' do
      before :each do
        Radiant::Config['shop.price_unit']      = '$'
        Radiant::Config['shop.price_precision'] = 2
        Radiant::Config['shop.price_separator'] = '.'
        Radiant::Config['shop.price_delimiter'] = ','
      end
      describe '<r:shop:package:price />' do
        before :each do
          @package.price = 1234.34567890
        end
        
        it 'should render a standard price' do
          tag = %{<r:shop:package:price />}
          exp = %{$1,234.35}
          @page.should render(tag).as(exp)
        end
        
        it 'should render a high precision price' do
          tag = %{<r:shop:package:price precision="8"/>}
          exp = %{$1,234.34567890}
          
          @page.should render(tag).as(exp)
        end
        
        it 'should render a custom format' do
          tag = %{<r:shop:package:price unit="%" separator="-" delimiter="+" />}
          exp = %{%1+234-35}
          
          @page.should render(tag).as(exp)
        end
      end
      
      describe '<r:shop:package:value />' do
        before :each do
          stub(@package).value { 1234.34567890 }
        end
        
        it 'should render a standard price' do
          tag = %{<r:shop:package:value />}
          exp = %{$1,234.35}
          
          @page.should render(tag).as(exp)
        end
        
        it 'should render a high precision price' do
          tag = %{<r:shop:package:value precision="8"/>}
          exp = %{$1,234.34567890}
          
          @page.should render(tag).as(exp)
        end
        
        it 'should render a custom format' do
          tag = %{<r:shop:package:value unit="%" separator="-" delimiter="+" />}
          exp = %{%1+234-35}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
  end
    
  context 'products in a package' do
    
    before :each do
      mock(ShopPackages::Tags::Helpers).current_package(anything) { @package }
    end
          
    describe '<r:shop:package:if_products>' do  
      context 'success' do
        it 'should render' do
          tag = %{<r:shop:package:if_products>success</r:shop:package:if_products>}
          exp = %{success}
          
          @page.should render(tag).as(exp)
        end
      end
      
      context 'failure' do
        it 'should not render' do
          stub(@package).products { [] }
          
          tag = %{<r:shop:package:if_products>failure</r:shop:package:if_products>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:package:unless_products>' do  
      context 'success' do
        it 'should render' do
          stub(@package).products { [] }
          tag = %{<r:shop:package:unless_products>success</r:shop:package:unless_products>}
          exp = %{success}
          
          @page.should render(tag).as(exp)
        end
      end
      
      context 'failure' do
        it 'should not render' do
          tag = %{<r:shop:package:unless_products>failure</r:shop:package:unless_products>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:package:products>' do
      it 'should render' do
        tag = %{<r:shop:package:products>success</r:shop:package:products>}
        exp = %{success}
        
        @page.should render(tag).as(exp)
      end
    end
    
    describe '<r:shop:package:products:each>' do
      context 'success' do
        it 'should render' do
          tag = %{<r:shop:package:products:each>.a.</r:shop:package:products:each>}
          exp = @package.products.map{'.a.'}.join('')
          
          @page.should render(tag).as(exp)
        end
      end
      
      context 'failure' do
        it 'should not render' do
          stub(@package).packings { [] }
          
          tag = %{<r:shop:package:products:each>failure</r:shop:package:products:each>}
          exp = %{}
          
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:package:product:quantity>' do
      it 'should render the quantity of the current packing' do
        tag = %{<r:shop:package:products:each:product:quantity />}
        exp = @package.packings.map{|p| p.quantity}.join('')
        
        @page.should render(tag).as(exp)
      end
    end
    
  end

end