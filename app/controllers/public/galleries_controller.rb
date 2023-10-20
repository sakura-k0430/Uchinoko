class Public::GalleriesController < ApplicationController
  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.customer_id = current_customer.id
    if @gallery.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to gallery_path(@gallery.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @galleries = Gallery.all.order(created_at: :desc)
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
    flash[:notice] = "投稿の編集に成功しました。"
    redirect_to gallery_path(gallery.id)
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    flash[:notice] = "投稿の削除に成功しました。"
    redirect_to galleries_path
  end

  def gallery_hashtag
    @customer = current_customer
    @tag = GalleryHashtag.find_by(hashname: params[:name])
    @galleries = @tag.galleries
  end

  private
  def gallery_params
    params.require(:gallery).permit(:customer_id,:title, :body, :gallery_image)
  end

end
