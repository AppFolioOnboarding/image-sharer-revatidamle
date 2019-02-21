module ImagesHelper
  def validate_url(url)
    regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix rescue false
    puts "The validation result for url "
    puts regex.match(url)
    return !!regex.match(url)

  end
end
