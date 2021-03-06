class MessagesController < ApplicationController
  before_action :set_chatroom
  before_action :authenticate_user!

  def create
    byebug
    @message = Message.create! content: params[:message][:content], chatroom: @chatroom, user: current_user
  end

  private
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
end
