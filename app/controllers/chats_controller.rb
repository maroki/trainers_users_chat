class ChatsController < ApplicationController
  before_action :authenticate_client!

  def index
    @chats = current_client.chats.all
  end

  def new
    @chat_creator = ChatCreator.new
  end

  def create
    @chat_creator = ChatCreator.new(chat_params)
    render 'new' and return unless @chat_creator.valid?

    chat = nil

    begin
      Chat.transaction do
        chat = Chat.create!(
          clients: [current_client, Client.find_by_id(@chat_creator.client_id)]
        )
        chat.messages.create!(body: @chat_creator.body, client: current_client)
      end

      redirect_to chat_path(chat)
    rescue => e
      render 'new'
    end
  end

  def show
    @chat = current_client.chats.find(params[:id])
    @messages = @chat.messages
    @message = Message.new
  end

  private

  def chat_params
    params.require(:chat_creator).permit(:client_id, :body)
  end
end
