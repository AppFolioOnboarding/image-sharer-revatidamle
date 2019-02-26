class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.valid?
      @image.save
      redirect_to @image.link
    else
      render new_image_path
    end
  end

  private

  def image_params
    params.require(:image).permit(:title, :link)
  end
end
