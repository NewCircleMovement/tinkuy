class Admin::TimeslotsController < Admin::BaseController

  def toggle_booking
    @timeslot = Timeslot.find(params[:id])
    @timeslot.toggle(:booked)
    @timeslot.save
    redirect_to :back
  end

end
