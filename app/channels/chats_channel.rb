class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params['chat_id']}_channel"
  end

  def unsubscribed
  end

  def send_message(data)
    current_client.messages.create!(body: data['message'], chat_id: data['chat_id'])
  end
end
