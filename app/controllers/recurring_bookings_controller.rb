class RecurringBookingsController < ApplicationController

  def create
    puts recurring_booking_params
    @recurring_booking = RecurringBooking.new(recurring_booking_params)
    @resource = Resource.find(params[:resource_id])

    if @recurring_booking.save
      @reserve_timeslots = Timeslot.where("startdate >= ?", params[:b_dato].to_date).where(:day => @recurring_booking.day, :starttime => @recurring_booking.time)
      
      @already_booked = []
      @reserve_timeslots.each do |timeslot|
        success = timeslot.recurring_book_and_save( @recurring_booking.user_id )
        unless success
          @already_booked << timeslot
        end
      end
      
      booked_dates = []
      @already_booked.each do |b|
        booked_dates << b.startdate.strftime('%-d/%-m')
      end

      if @already_booked.length > 0
        message = "Du har booket denne tid hver uge fremover. Desværre kunne #{booked_dates.join(', ')} ikke bookes"
      else
        message = "Du har booket denne tid hver uge fremover"
      end      
      redirect_to resource_path(@resource, :b_dato => params[:b_dato]), :notice => message
    else
      redirect_to resource_path(@resource, :b_dato => params[:b_dato]), :notice => "Der opstod desværre en fejl"
    end
  end


  def destroy
    @recurring_booking = RecurringBooking.find(params[:id])
    booked_timeslots = Timeslot.where(:day => @recurring_booking.day, :starttime => @recurring_booking.time)

    resource = booked_timeslots.first.resource

    booked_timeslots.each do |timeslot|
      if timeslot.is_recurring
        timeslot.booked = false
        timeslot.is_recurring = false
        timeslot.save!
      end
    end
    @recurring_booking.destroy
    redirect_to resource_path(resource, {:b_date => params[:b_date]}), :notice => "Du har nu slettet din faste booking"
  end


  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_booking_params
      params.require(:recurring_booking).permit(:day, :time, :user_id, :startdate, :resource_id)
    end

end