class Public::GalleryCommentsController < ApplicationController
  def create
    gallery = Gallery.find(params[:gallery_id])
    comment = current_customer.gallery_comments.new(gallery_comment_params)
    comment.gallery_id = gallery.id
    comment.save
    redirect_to gallery_path(gallery)
  end

  def destroy
    GalleryComment.find(params[:id]).destroy
    redirect_to gallery_path(params[:gallery_id])
  end

  private

  def gallery_comment_params
    params.require(:gallery_comment).permit(:comment)
  end
end
