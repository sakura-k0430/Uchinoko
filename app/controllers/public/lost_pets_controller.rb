class Public::LostPetsController < ApplicationController
  def new
    @lost_pet = LostPet.new
  end

  def create
    @lost_pet = LostPet.new(lost_pet_params)
    @lost_pet.customer_id = current_customer.id
    if @lost_pet.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to  lost_pet_path(@lost_pet.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @lost_pets = LostPet.all.order(created_at: :desc)
    @lost_pet = LostPet.new
  end

  def show
    @lost_pet = LostPet.find(params[:id])
    @lost_pet_comment = LostPetComment.new
  end

  def edit
    @lost_pet = LostPet.find(params[:id])
  end

  def update
    lost_pet = LostPet.find(params[:id])
    lost_pet.update(lost_pet_params)
    flash[:notice] = "投稿の編集に成功しました。"
    redirect_to lost_pet_path(lost_pet.id)
  end

  def destroy
    lost_pet = LostPet.find(params[:id])
    lost_pet.destroy
    flash[:notice] = "投稿の削除に成功しました。"
    redirect_to lost_pets_path
  end

  def lost_pet_hashtag
    @customer = current_customer
    @tag = LostPetHashtag.find_by(hashname: params[:name])
    @lost_pets = @tag.lost_pets
  end

  private
  def lost_pet_params
    params.require(:lost_pet).permit(:customer_id,:title, :body, :lost_pet_image)
  end
end
