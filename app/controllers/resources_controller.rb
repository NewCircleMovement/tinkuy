# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  duration    :integer
#

class ResourcesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_dates

  def index
    @rooms = Resource.all
  end

  def show
    @weekdays = {1 => "Mandag", 2 => "Tirsdag", 3 => "Onsdag", 4 => "Torsdag", 5 => "Fredag", 6 => "Lørdag", 0 => "Søndag"}
    @room = Resource.find(params[:id])
    if params[:b_dato].present?
      session[:b_dato] = params[:b_dato].to_date
    else
      session[:b_dato] = Date.today
    end
    session[:next] = session[:b_dato] + 7.days
    session[:prev] = session[:b_dato] - 7.days
    @show_week = session[:b_dato].cweek
  end


  def get_dates
    session[:dato_b] = Date.today.beginning_of_week
  end

end
