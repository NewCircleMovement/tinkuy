class PagesController < ApplicationController

  def index
  	@places_left = 300 - User.all.length
    @confirmed_members = User.where(:active => true).length
  end

end
