class Public::FosterParentFavoritesController < ApplicationController
  def create
    foster_parent = FosterParent.find(params[:foster_parent_id])
    favorite = current_customer.foster_parent_favorites.new(foster_parent_id: foster_parent.id)
    favorite.save
    redirect_to foster_parent_path(foster_parent)
  end

  def destroy
    foster_parent = FosterParent.find(params[:foster_parent_id])
    favorite = current_customer.foster_parent_favorites.find_by(foster_parent_id: foster_parent.id)
    favorite.destroy
    redirect_to foster_parent_path(foster_parent)
  end
end
