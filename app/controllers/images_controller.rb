class ImagesController < ApplicationController
  def index
    @image = if params[:tag].present?
               Image.tagged_with(params[:tag])
             else
               Image.all
             end
  end

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
    params.require(:image).permit(:title, :link, :tag_list)
  end
end
