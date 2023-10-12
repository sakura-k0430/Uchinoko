class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @galleries = @customer.galleries
    @lost_pets = @customer.lost_pets
    @foster_parents = @customer.foster_parents
  # 以下DM機能で使用
    # roomがcreateされた時現在ログインしているユーザーと「チャットへ」ボタンを押されたユーザーの両方をEntriesテーブルに記録するため
    @currentCustomerEntry = Entry.where(customer_id: current_customer.id)
    # whereメソッドを使いもう1人のユーザーを探している
    @customerEntry = Entry.where(customer_id: @customer.id)
    # 現在ログインしているユーザーではない
    if @customer.id == current_customer.id
    else
      # roomが作成されている場合、Entriesテーブル内にあるroom_idが共通しているユーザー同士に対して
      @currentCustomerEntry.each do |currentcustomer|
        @customerEntry.each do |customer|
          if currentcustomer.room_id == customer.room_id
            @isRoom = true
            # すでに作成されているroom_idを特定
            @roomId = currentcustomer.room_id
          end
        end
      end
      # roomが作成されていない場合は新しいroomの作成
    if @isRoom
    else
      @room = Room.new
      @entry = Entry.new
    end
    end
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

  # 自身の投稿とフォローしている人の全ての投稿(タイムライン表示)
  def followings_post
    @gallery_posts = Gallery.where(customer_id: [current_customer.id, *current_customer.following_ids]).order(created_at: :desc)
    @lost_pet_posts = LostPet.where(customer_id: [current_customer.id, *current_customer.following_ids]).order(created_at: :desc)
    @foster_parent_posts = FosterParent.where(customer_id: [current_customer.id, *current_customer.following_ids]).order(created_at: :desc)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :address)
  end

end