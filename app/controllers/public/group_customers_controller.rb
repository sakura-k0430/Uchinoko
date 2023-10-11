class Public::GroupCustomersController < ApplicationController
  before_action :authenticate_customer!

  # グループに参加するために、group_customersという中間テーブルにユーザーとグループの関連を作成する
  def create
    # 現在のユーザーを取得し、group_customersにnewメソッドで新しいレコードを作成、group_idを渡してどのグループに参加するか指定
    group_customer = current_customer.group_customers.new(group_id: params[:group_id])
    group_customer.save
    redirect_to request.referer
  end

  def destroy
    # ログインしているユーザーの group_customers 関連付けを使用して、指定されたグループに関連付けられた group_customerインスタンスをfind_byメソッドで検索
    group_customer = current_customer.group_customers.find_by(group_id: params[:group_id])
    group_customer.destroy
    redirect_to request.referer
  end

end
