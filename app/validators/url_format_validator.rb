require 'uri'
class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    record.errors.add(attribute, 'Invalid URL: ' + value) unless %w[https http].include?(uri.scheme)
    valid_image_regex = /.\.(png|jpeg|jpg|gif)$/
    record.errors.add(attribute, 'URL not an image : ' + value) unless valid_image_regex.match?(value)
  end
end
