class Public::FosterParentCommentsController < ApplicationController
  def create
    foster_parent = FosterParent.find(params[:foster_parent_id])
    comment = current_customer.foster_parent_comments.new(foster_parent_comment_params)
    comment.foster_parent_id = foster_parent.id
    comment.save
    redirect_to foster_parent_path(foster_parent)
  end

  def destroy
    FosterParentComment.find(params[:id]).destroy
    redirect_to foster_parent_path(params[:foster_parent_id])
  end

  private

  def foster_parent_comment_params
    params.require(:foster_parent_comment).permit(:comment)
  end
end
