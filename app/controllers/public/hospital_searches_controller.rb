class Public::HospitalSearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
# looksメソッドを使い検索内容を取得し、変数に代入
    if @range == "Hospital"
      @hospitals = Hospital.looks(params[:search], params[:word])
    else
      @genres = Genre.looks(params[:search], params[:word])
    end
  end

end
