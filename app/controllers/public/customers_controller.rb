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

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :address)
  end

end