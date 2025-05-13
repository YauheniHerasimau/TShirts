class Admin::MessagesController < ApplicationController

  before_action :authenticate_admin!
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :update]

  def index
    @unread_messages = Message.unread.recent
    @read_messages = Message.read.recent
    @messages = Message.recent
  end

  def show
    @message = Message.find(params[:id])
    @message.update(read: true) unless @message.read
  end

  def update
    if @message.update(admin_message_params)
      redirect_to admin_message_path
    else
      render :show
    end
  end

  private

  def admin_message_params
    params.require(:message).permit(:admin_reply)
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You do not have access to this page."
    end
  end
end
