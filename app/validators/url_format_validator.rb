require 'uri'
class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    uri = begin
            URI.parse(value)
          rescue StandardError
            false
          end
    record.errors.add(attribute, 'Invalid URL: ' + value) unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    valid_image_regex = /.\.(png|jpeg|jpg|gif)$/
    record.errors.add(attribute, 'URL not an image : ' + value) unless valid_image_regex.match?(value)
  end
end
