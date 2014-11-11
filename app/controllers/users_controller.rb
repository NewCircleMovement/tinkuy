class UsersController < ApplicationController
  
  def index
    @confirmed_users = User.where(:status => 'active').order(:firstname, :surname)
    @pending_users = User.where(:status => 'pending').order(:firstname, :surname)
  end

end