class SetupShopPackages < ActiveRecord::Migration
  def self.up
    create_table "shop_packages", :force => true do |t|
      t.string   "name"
      t.string   "sku"
      t.text     "description"
      t.boolean  "is_active",   :default => true
      t.decimal  "price"
      t.integer  "created_by"
      t.integer  "updated_by"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "shop_packings", :force => true do |t|
      t.integer "quantity",   :default => 1
      t.integer "position"
      t.integer "product_id"
      t.integer "package_id"
    end
  end

  def self.down
    remove_table 'shop_packages'
    remove_table 'shop_packings'
  end
end
