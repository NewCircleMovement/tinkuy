module Api
  class UsersController < ApplicationController
    http_basic_authenticate_with name: TINKUY_API_USER, password: TINKUY_API_PASSWORD

    respond_to :json

    def index
      @users = User.where.not(status: "passive")
      render :json => @users
    end

  end
end
