class Public::LostPetCommentsController < ApplicationController
  def create
    lost_pet = LostPet.find(params[:lost_pet_id])
    comment = current_customer.lost_pet_comments.new(lost_pet_comment_params)
    comment.lost_pet_id = lost_pet.id
    comment.save
    redirect_to lost_pet_path(lost_pet)
  end

  def destroy
    LostPetComment.find(params[:id]).destroy
    redirect_to lost_pet_path(params[:lost_pet_id])
  end

  private

  def lost_pet_comment_params
    params.require(:lost_pet_comment).permit(:comment)
  end
end
