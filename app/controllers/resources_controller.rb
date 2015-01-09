class ResourcesController < ApplicationController

  def index
    @weekdays = {1 => "Mandag", 2 => "Tirsdag", 3 => "Onsdag", 4 => "Torsdag", 5 => "Fredag", 6 => "Lørdag", 0 => "Søndag"}
    @rooms = Resource.all
    @week = 3
  end

end
