class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
# looksメソッドを使い検索内容を取得し、変数に代入
    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
    elsif @range == "Gallery"
      @galleries = Gallery.looks(params[:search], params[:word])
    elsif @range == "LostPet"
      @lost_pets = LostPet.looks(params[:search], params[:word])
    else
      @foster_parents = FosterParent.looks(params[:search], params[:word])
    end
  end
end
