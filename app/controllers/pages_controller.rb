class PagesController < ApplicationController

  def index
    @confirmed_members = User.where(:active => true).length #not in use? 
  end

  def info
  	
  end

end
