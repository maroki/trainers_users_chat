class HomeController < ApplicationController
  def index
    if client_signed_in?
      @trainers_counter = Client.trainer.count
      @users_counter = Client.user.count

      @last_trainer = Client.trainer.order(:id).last
      @last_user = Client.user.order(:id).last
    end
  end
end
