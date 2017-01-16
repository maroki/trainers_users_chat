class CreateChatsClients < ActiveRecord::Migration[5.0]
  def change
    create_table :chats_clients, id: false do |t|
      t.belongs_to :chat, index: true
      t.belongs_to :client, index: true
    end
  end
end
