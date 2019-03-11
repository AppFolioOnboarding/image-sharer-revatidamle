class Image < ApplicationRecord
  default_scope { order('created_at DESC') }
  validates :link, url_format: true
  validates :title, presence: true
  acts_as_taggable_on :tags
end
