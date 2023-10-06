class Public::LostPetFavoritesController < ApplicationController
  def create
    lost_pet = LostPet.find(params[:lost_pet_id])
    favorite = current_customer.lost_pet_favorites.new(lost_pet_id: lost_pet.id)
    favorite.save
    redirect_to lost_pet_path(lost_pet)
  end

  def destroy
    lost_pet = LostPet.find(params[:lost_pet_id])
    favorite = current_customer.lost_pet_favorites.find_by(lost_pet_id: lost_pet.id)
    favorite.destroy
    redirect_to lost_pet_path(lost_pet)
  end
end
