class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      # 更新に成功したら会員詳細画面へ遷移
      redirect_to admin_customer_path(@customer)
      flash[:notice] = "会員情報を更新しました。"
    else
      render edit_admin_customer_path
    end
  end

private

  def customer_params
    params.require(:customer).permit(:name, :email,:address, :is_deleted, :introduction)
  end
end
