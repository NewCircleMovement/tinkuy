module Api
  class UsersController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "give_me_api"

    respond_to :json

    def index
      respond_with User.all
    end



  end
end
