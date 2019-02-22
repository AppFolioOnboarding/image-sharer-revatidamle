class ImagesController < ApplicationController
  include ImagesHelper
  def create
    image_params =  params.require(:image).permit([:title, :link])
    url = image_params[:link]
    valid = validate_url(url)
    raise ArgumentError.new("Not a valid URL") if not valid
    @image = Image.new(image_params)
    @image.save
    redirect_to @image
  end
  def show
    @image = Image.find(params[:id])
    redirect_to @image.link

  end
  def index
    @images = Image.all
  end
end

