# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # createアクションが実行される前に退会確認を行う
   before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # ゲストログイン用
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected
  # 退会しているかを判断するメソッド
  def customer_state
    # 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別&&Customerモデルに記述した、active_for_authentication?メソッドがfalseであるか判断
    if (@customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true))
      flash[:notice] = "退会済みです。再度新規登録をしてご利用ください"
      redirect_to new_customer_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
