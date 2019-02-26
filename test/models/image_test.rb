require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_valid_image
    im = Image.new(title: 'test_1', link: 'https://cdn.pixabay.com/photo/2013/08/22/19/18/rose-174817__340.jpg')
    assert_predicate im, :valid?
  end

  def test_link__invalid_url
    im = Image.new(title: 'test_1', link: 'htt://www.google.jpg')
    assert_not_predicate im, :valid?
    assert_equal 'Invalid URL: htt://www.google.jpg', im.errors.messages[:link].first
  end

  def test_link__valid_non_image_url
    im = Image.new(title: 'test_1', link: 'https://google.com')
    assert_not_predicate im, :valid?
    assert_equal 'URL not an image : https://google.com', im.errors.messages[:link].first
  end

  def test_title__presence_invalid
    im = Image.new(title: '', link: 'https://google.jpg')
    assert_not_predicate im, :valid?
    assert_equal "can't be blank", im.errors.messages[:title].first
  end

  def test_title__presence_valid
    im = Image.new(title: 'test_title', link: 'https://google.jpg')
    assert_predicate im, :valid?
  end

  def test_link__invalid_url__with_space
    im = Image.new(title: 'test_title', link: 'skdjshf sdkfhsd')
    assert_predicate im, :invalid?
  end
end
