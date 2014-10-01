class Admin::EventsController < ApplicationController

  def index
    @confirmed_events = Event.where(:confirmed => true).order(startdate: :asc, starttime: :asc)
    @unconfirmed_events = Event.where(:confirmed => false).order(startdate: :asc, starttime: :asc)
  end

end
