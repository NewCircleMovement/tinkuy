class PagesController < ApplicationController

  def index
    @confirmed_members = User.where(:status => 'active').length #not in use? 
  end

  def info
  	
  end

end
