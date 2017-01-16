class ChatCreator
  include ActiveModel::Model

  attr_accessor :body, :client_id
  validates :body, :client_id, presence: true

  validates :body, length: { minimum: 2, maximum: 1000 }
end
