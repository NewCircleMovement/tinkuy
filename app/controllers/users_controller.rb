class UsersController < ApplicationController
  
  def index
    @confirmed_users = User.where(:active => true)
    @pending_users = User.where(:pending => true)
  end

end