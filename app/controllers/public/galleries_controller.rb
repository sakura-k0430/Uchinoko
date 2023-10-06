class Public::GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  def create
    gallery = Gallery.new(gallery_params)
    gallery.customer_id = current_customer.id
    gallery.save
    redirect_to  gallery_path(gallery.id)
  end

  def index
    @galleries = Gallery.all
    @gallery = Gallery.new
  end

  def show
    @gallery = Gallery.find(params[:id])
    @gallery_comment = GalleryComment.new
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    gallery = Gallery.find(params[:id])
    gallery.update(gallery_params)
    redirect_to gallery_path(gallery.id)
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    redirect_to galleries_path
  end

  private
  def gallery_params
    params.require(:gallery).permit(:customer_id,:title, :body, :gallery_image)
  end

end
