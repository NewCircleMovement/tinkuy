class ResourcesController < ApplicationController
  before_filter :get_dates

  def index
    @weekdays = {1 => "Mandag", 2 => "Tirsdag", 3 => "Onsdag", 4 => "Torsdag", 5 => "Fredag", 6 => "Lørdag", 0 => "Søndag"}
    @rooms = Resource.all

    if params[:b_dato].present?
      session[:b_dato] = params[:b_dato].to_date
    else
      session[:b_dato] = Date.today
    end
    session[:next] = session[:b_dato] + 7.days
    session[:prev] = session[:b_dato] - 7.days
    @show_week = session[:b_dato].cweek
    # @week = 3
  end

  def get_dates
    session[:dato_b] = Date.today.beginning_of_week
  end

end
