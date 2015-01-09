class BookingsController < ApplicationController

  def new
    @room = Resource.find(params[:resource_id])
    @timeslot = Timeslot.find(params[:timeslot_id])
    @booking = @timeslot.bookings.build
  end

  def create
    room = Resource.find(params[:resource_id])
    timeslot = Timeslot.find(params[:timeslot_id])
    @timeslot = timeslot
    @booking = timeslot.bookings.create( params[:booking].permit(:user_id, :timeslot_id, :lemons) )

    booking_fruitbasket = Fruitbasket.create(:owner_id => @booking.id, :owner_type => 'Booking')

    if @booking.lemons <= current_user.fruitbasket.fruits_count
      if @booking.save

        # booking must first have fruits
        current_user.fruitbasket.give_fruits_to( booking_fruitbasket, @booking.lemons )

        # book if booking is in current week - or fruits more than 50
        if (timeslot.startdate.cweek == Date.today.cweek) or (@booking.lemons >= 50)
          timeslot.book_and_save
          redirect_to resources_path, :notice => "Tillykke! Rummet er dit"
        else
          redirect_to resources_path, :notice => "Du har budt ind med #{@booking.lemons} frugter"
        end
      else
        render action: 'new'
      end
    else
      redirect_to new_resource_timeslot_booking_path(room, timeslot), :notice => "Du har ikke nok frugter"
    end

  end


end