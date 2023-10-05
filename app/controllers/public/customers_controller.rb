class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @galleries = @customer.galleries
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
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :address)
  end

end