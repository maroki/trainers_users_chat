class Chat < ApplicationRecord
  has_and_belongs_to_many :clients
  has_many :messages, dependent: :destroy

  def clients_except(client)
    companions_of(client).select(:email)
  end

  def companions_of(client)
    clients.where.not(id: client)
  end
end
