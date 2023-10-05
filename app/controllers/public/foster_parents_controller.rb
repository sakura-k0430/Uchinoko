class Public::FosterParentsController < ApplicationController
  def new
    @foster_parent = FosterParent.new
  end

  def create
    foster_parent = FosterParent.new(foster_parent_params)
    foster_parent.customer_id = current_customer.id
    foster_parent.save
    redirect_to  foster_parent_path(foster_parent.id)
  end

  def index
    @foster_parents = FosterParent.all
    @foster_parent = FosterParent.new
  end

  def show
    @foster_parent = FosterParent.find(params[:id])
  end

  def edit
    @foster_parent = FosterParent.find(params[:id])
  end

  def update
    foster_parent = FosterParent.find(params[:id])
    foster_parent.update(foster_parent_params)
    redirect_to foster_parent_path(foster_parent.id)
  end

  def destroy
    foster_parent = FosterParent.find(params[:id])
    foster_parent.destroy
    redirect_to foster_parents_path
  end

  private
  def foster_parent_params
    params.require(:foster_parent).permit(:customer_id,:title, :body, :foster_parent_image)
  end
end
