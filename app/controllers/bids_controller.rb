class BidsController < ApplicationController
  # before_action :authenticate_user!

  def new
    if current_user
      @bid = Bid.find_or_create_by(:user_id => current_user.id, :event_id => params[:event_id])
      render :json => @bid
    else
      render :json => nil
    end
  end    


  

end