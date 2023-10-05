class Public::LostPetsController < ApplicationController
  def new
    @lost_pet = LostPet.new
  end

  def create
    lost_pet = LostPet.new(lost_pet_params)
    lost_pet.customer_id = current_customer.id
    lost_pet.save
    redirect_to  lost_pet_path(lost_pet.id)
  end

  def index
    @lost_pets = LostPet.all
    @lost_pet = LostPet.new
  end

  def show
    @lost_pet = LostPet.find(params[:id])
  end

  def edit
    @lost_pet = LostPet.find(params[:id])
  end

  def update
    lost_pet = LostPet.find(params[:id])
    lost_pet.update(lost_pet_params)
    redirect_to lost_pet_path(lost_pet.id)
  end

  def destroy
    lost_pet = LostPet.find(params[:id])
    lost_pet.destroy
    redirect_to lost_pets_path
  end

  private
  def lost_pet_params
    params.require(:lost_pet).permit(:customer_id,:title, :body, :lost_pet_image)
  end
end
