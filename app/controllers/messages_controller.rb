class MessagesController < ApplicationController
  def new
    @message = current_user.messages.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to messages_path
    else
      render :new
    end
  end

  def index
    @messages = current_user.messages
  end

  def show
    @message = current_user.messages.find(params[:id])
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
