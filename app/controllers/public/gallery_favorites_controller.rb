class Public::GalleryFavoritesController < ApplicationController
  def create
    gallery = Gallery.find(params[:gallery_id])
    favorite = current_customer.gallery_favorites.new(gallery_id: gallery.id)
    favorite.save
    redirect_to gallery_path(gallery)
  end

  def destroy
    gallery = Gallery.find(params[:gallery_id])
    favorite = current_customer.gallery_favorites.find_by(gallery_id: gallery.id)
    favorite.destroy
    redirect_to gallery_path(gallery)
  end
end