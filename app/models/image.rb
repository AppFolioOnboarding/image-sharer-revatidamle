class Image < ApplicationRecord
  validates :link, url_format: true
  validates :title, presence: true
  acts_as_taggable_on :tags
end
