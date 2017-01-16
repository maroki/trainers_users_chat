class Message < ApplicationRecord
  belongs_to :client
  belongs_to :chat

  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
