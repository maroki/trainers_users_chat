class Client < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { trainer: 0, user: 1 }

  has_and_belongs_to_many :chats, dependent: :nullify
  has_many :messages, dependent: :nullify

  validates :role, presence: true

  scope :chatting_with,
        -> (client) { joins(:chats).where(chats: {id: client.chats.pluck(:id)}).distinct }

  scope :not_chatting_with,
        -> (client) { where.not(id: chatting_with(client).pluck(:id)) }

  class << self
    def can_start_chat_with(client)
      not_chatting_with(client).where.not(id: client.id).select(:id, :email, :role)
    end
  end

  def name
    email.split('@')[0]
  end
end
