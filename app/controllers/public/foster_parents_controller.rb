class Public::FosterParentsController < ApplicationController
  def new
    @foster_parent = FosterParent.new
  end

  def create
    @foster_parent = FosterParent.new(foster_parent_params)
    @foster_parent.customer_id = current_customer.id
    if @foster_parent.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to  foster_parent_path(@foster_parent.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @foster_parents = FosterParent.all.order(created_at: :desc)
  end

  def show
    @foster_parent = FosterParent.find(params[:id])
    @foster_parent_comment = FosterParentComment.new
  end

  def edit
    @foster_parent = FosterParent.find(params[:id])
  end

  def update
    foster_parent = FosterParent.find(params[:id])
    foster_parent.update(foster_parent_params)
    flash[:notice] = "投稿の編集に成功しました。"
    redirect_to foster_parent_path(foster_parent.id)
  end

  def destroy
    foster_parent = FosterParent.find(params[:id])
    foster_parent.destroy
    flash[:notice] = "投稿の削除に成功しました。"
    redirect_to foster_parents_path
  end

  def foster_parent_hashtag
    @customer = current_customer
    @tag = FosterParentHashtag.find_by(hashname: params[:name])
    @foster_parents = @tag.foster_parents
  end

  private
  def foster_parent_params
    params.require(:foster_parent).permit(:customer_id,:title, :body, :foster_parent_image)
  end
end
