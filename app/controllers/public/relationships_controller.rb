class Public::RelationshipsController < ApplicationController
  # フォローする時
  def create
    current_customer.follow(params[:customer_id])
    # request.refererでフォローした時の画面に戻る
    redirect_to request.referer
  end
  # フォローを外す時
  def destroy
    current_customer.unfollow(params[:customer_id])
    # request.refererでフォロー外した時の画面に戻る
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
