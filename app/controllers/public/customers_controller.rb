class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @galleries = @customer.galleries
    @lost_pets = @customer.lost_pets
    @foster_parents = @customer.foster_parents
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  def check
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    # セッション情報を全て削除
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    # 退会後トップ画面に遷移
    redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    # GalleryFavoriteのテーブルから @customerのcustomer_idを見つけ出してきてpluckで特定のカラム(gallery_id)のデータを取得
    gallery_favorites = GalleryFavorite.where(customer_id: @customer.id).pluck(:gallery_id)
    # 上記で取得してきたデータを引き渡す
    @favorite_galleries = Gallery.find(gallery_favorites)
    @gallery = Gallery.find(params[:id])

    lost_pet_favorites = LostPetFavorite.where(customer_id: @customer.id).pluck(:lost_pet_id)
    @favorite_lost_pets = LostPet.find(lost_pet_favorites)
    @lost_pet = LostPet.find(params[:id])

    foster_parent_favorites = FosterParentFavorite.where(customer_id: @customer.id).pluck(:foster_parent_id)
    @favorite_foster_parents = FosterParent.find(foster_parent_favorites)
    @foster_parent = FosterParent.find(params[:id])
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :address)
  end

end