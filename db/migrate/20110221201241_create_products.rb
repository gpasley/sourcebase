class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :product_name
      t.integer :company_id
      t.string :website
      t.text :overview
      t.boolean :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
