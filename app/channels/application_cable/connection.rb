module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_client

    def connect
      self.current_client = find_verified_client
      logger.add_tags 'ActionCable', current_client.email
    end

    protected

    def find_verified_client
      if verified_client = env['warden'].user
        verified_client
      else
        reject_unauthorized_connection
      end
    end
  end
end
