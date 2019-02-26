class Image < ApplicationRecord
  validates :link, url_format: true
  validates :title, presence: true
end
