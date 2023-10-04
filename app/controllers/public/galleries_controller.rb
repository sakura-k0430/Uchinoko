class Public::GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  def create
    gallery = Gallery.new(gallery_params)
    gallery.save
    redirect_to  gallery_path(gallery.id)
  end

  def index
    @galleries = Gallery.all
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    gallery = List.find(params[:id])
    gallery.update(gallery_params)
    redirect_to gallery_path(gallery.id)
  end

  def destroy
    gallery = List.find(params[:id])
    gallery.destroy
    redirect_to galleries_path
  end

  private
  def gallery_params
    params.require(:gallery).permit(:title, :body, :gallery_image)
  end

end
