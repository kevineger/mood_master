class Content < ActiveRecord::Base
  belongs_to :post
  validates_formatting_of :link, using: :url
end
