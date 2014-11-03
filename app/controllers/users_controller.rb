class UsersController < ApplicationController
  
  def index
    @confirmed_users = User.where(:active => true).order(:firstname, :surname)
    @pending_users = User.where(:pending => true).order(:firstname, :surname)
  end

end