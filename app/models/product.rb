class Product < ActiveRecord::Base
  belongs_to :company
  has_friendly_id :product_name, :use_slug => true
  versioned
  acts_as_taggable_on :tags
end
