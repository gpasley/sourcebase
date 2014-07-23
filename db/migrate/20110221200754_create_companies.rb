class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :company_name
      t.string :description
      t.string :blog_url
      t.string :website
      t.string :twitter
      t.string :phone
      t.string :email
      t.text :overview
      t.string :category
      t.string :number_of_employees
      t.string :stock_symbol
      t.string :blog_feed_url
      t.datetime :founded_on
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_code
      t.string :country
      t.string :postal_code
      t.boolean :deleted
      t.string :facebook
      t.string :youtube

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
