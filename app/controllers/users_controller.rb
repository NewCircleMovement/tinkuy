class UsersController < ApplicationController
  
  def index
    @confirmed_users = User.where(:status => 'active').order(:firstname, :surname)
    @pending_users = User.where(:status => 'pending').order(:firstname, :surname)
  end

  def events
  	@user = User.find(params[:user_id])
  	@events = @user.events.order(startdate: :desc)
  end

end