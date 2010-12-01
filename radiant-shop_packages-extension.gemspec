# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-shop_packages-extension}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dirk Kelly"]
  s.date = %q{2010-12-01}
  s.description = %q{RadiantShop: Group up Products into packages, you can assign a price to a package}
  s.email = %q{dk@dirkkelly.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
    "Rakefile",
    "VERSION",
    "app/controllers/.DS_Store",
    "app/controllers/admin/shop/packages/packings_controller.rb",
    "app/controllers/admin/shop/packages_controller.rb",
    "app/datasets/shop_packages.rb",
    "app/models/shop_package.rb",
    "app/models/shop_packing.rb",
    "app/views/admin/shop/packages/edit.html.haml",
    "app/views/admin/shop/packages/edit/_foot.html.haml",
    "app/views/admin/shop/packages/edit/_form.html.haml",
    "app/views/admin/shop/packages/edit/_head.html.haml",
    "app/views/admin/shop/packages/edit/_inputs.html.haml",
    "app/views/admin/shop/packages/edit/_meta.html.haml",
    "app/views/admin/shop/packages/edit/_parts.html.haml",
    "app/views/admin/shop/packages/edit/_popups.html.haml",
    "app/views/admin/shop/packages/edit/buttons/_browse_products.html.haml",
    "app/views/admin/shop/packages/edit/inputs/_name.html.haml",
    "app/views/admin/shop/packages/edit/inputs/_price.html.haml",
    "app/views/admin/shop/packages/edit/meta/_sku.html.haml",
    "app/views/admin/shop/packages/edit/parts/_description.html.haml",
    "app/views/admin/shop/packages/edit/parts/_products.html.haml",
    "app/views/admin/shop/packages/edit/popups/_browse_products.html.haml",
    "app/views/admin/shop/packages/edit/shared/_product.html.haml",
    "app/views/admin/shop/packages/index.html.haml",
    "app/views/admin/shop/packages/index/_foot.html.haml",
    "app/views/admin/shop/packages/index/_head.html.haml",
    "app/views/admin/shop/packages/index/_package.html.haml",
    "app/views/admin/shop/packages/index/buttons/_new_package.html.haml",
    "app/views/admin/shop/packages/new.html.haml",
    "app/views/admin/shop/packages/remove.html.haml",
    "config/locales/en.yml",
    "config/routes.rb",
    "cucumber.yml",
    "db/migrate/20101015161749_setup_shop_packages.rb",
    "lib/radiant-shop_packages-extension.rb",
    "lib/shop_packages/interface/packages.rb",
    "lib/shop_packages/models/shop_packageable.rb",
    "lib/shop_packages/tags/helpers.rb",
    "lib/shop_packages/tags/package.rb",
    "lib/tasks/shop_packages_extension_tasks.rake",
    "public/javascripts/admin/extensions/shop/packages/edit.js",
    "public/stylesheets/sass/admin/extensions/shop/packages/edit.sass",
    "radiant-shop_packages-extension.gemspec",
    "shop_packages_extension.rb",
    "spec/controllers/admin/shop/packages/packings_controller_spec.rb",
    "spec/controllers/admin/shop/packages_controller_spec.rb",
    "spec/datasets/shop_packages.rb",
    "spec/lib/shop_packages/tags/package_spec.rb",
    "spec/models/shop_package_spec.rb",
    "spec/models/shop_packing_spec.rb",
    "spec/models/shop_product_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/thefrontiergroup/radiant-shop_packages-extension}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Shop Packages Extension for Radiant CMS}
  s.test_files = [
    "spec/controllers/admin/shop/packages/packings_controller_spec.rb",
    "spec/controllers/admin/shop/packages_controller_spec.rb",
    "spec/datasets/shop_packages.rb",
    "spec/lib/shop_packages/tags/package_spec.rb",
    "spec/models/shop_package_spec.rb",
    "spec/models/shop_packing_spec.rb",
    "spec/models/shop_product_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<radiant-shop-extension>, [">= 0"])
    else
      s.add_dependency(%q<radiant-shop-extension>, [">= 0"])
    end
  else
    s.add_dependency(%q<radiant-shop-extension>, [">= 0"])
  end
end

