module Api
  class UsersController < ApplicationController
    http_basic_authenticate_with name: "admin", password: "give_me_api"

    respond_to :json

    def index
      @users = User.where.not(status: "passive")
      render :json => @users
    end

  end
end
