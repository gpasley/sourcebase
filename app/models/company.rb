class Company < ActiveRecord::Base
  has_many :categories
  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :reject_if => lambda { |a| a[:product_name].blank? }, :allow_destroy => true
  has_friendly_id :company_name, :use_slug => true
  versioned
  acts_as_taggable_on :tags
  mount_uploader :logo, ImageUploader
  
#  validates_format_of(:website, :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/, :on => :create, :message=>"has an invalid format", :if => :url_filled?)
#  validates_format_of(:blog_url, :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/, :on => :create, :message=>"has an invalid format", :if => :blog_url_filled?)

  def url_filled?
    !website.blank?
  end
  def blog_url_filled?
    !blog_url.blank?
  end
  
  
end
