class Public::RoomsController < ApplicationController
  before_action :authenticate_customer!

  def create
    # マイページのform_forの@roomで送られてきたパラメータを、ここで受け取りcreate
    @room = Room.create(customer_id: current_customer.id)
    # 子モデルのEntryもcreateするためEntriesテーブルに入る相互フォロー同士のユーザーを以下で保存
    # 現在ログインしているユーザー
    @entry1 = Entry.create(:room_id => @room.id, :customer_id => current_customer.id)
    # フォローされているユーザー
    # マイページのfields_for @entryで保存したparamsの情報(:customer_id, :room_id)を許可
    @entry2 = Entry.create(params.require(:entry).permit(:customer_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # 現在ログインしているユーザーのidとそれにひもづいたチャットルームのidをwhereメソッドで探す
    if Entry.where(:customer_id => current_customer.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    #Roomで相手の名前表示する
      @mycustomerId = current_customer.id
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
