class BookingsController < ApplicationController


  def new
    @room = Resource.find(params[:resource_id])
    @timeslot = Timeslot.find(params[:timeslot_id])

    if @timeslot.bookings.where(:user_id => current_user.id).present?
      @booking = @timeslot.bookings.where(:user_id => current_user.id).first
      redirect_to edit_resource_timeslot_booking_path(@room, @timeslot, @booking), :notice => "Du har en aktiv booking. Men du kan give den flere frugter"
    else
      @booking = @timeslot.bookings.build
    end
    @minimum = @timeslot.minimum
  end


  def edit
    @room = Resource.find(params[:resource_id])
    @timeslot = Timeslot.find(params[:timeslot_id])
    @booking = Booking.find(params[:id])
    @minimum = @timeslot.minimum
  end


  def create
    @room = Resource.find(params[:resource_id])
    @timeslot = Timeslot.find(params[:timeslot_id])
    @booking = @timeslot.bookings.create( params[:booking].permit(:user_id, :timeslot_id, :lemons) )

    if @booking.lemons <= current_user.fruitbasket.fruits_count      
      # create fruitbasket for the booking
      booking_fruitbasket = Fruitbasket.create(:owner_id => @booking.id, :owner_type => 'Booking')
      
      if @booking.save
        # user gives fruit to booking
        current_user.fruitbasket.give_fruits_to( booking_fruitbasket, @booking.lemons )

        # book if booking is in current week or if fruits >= 50
        if (@timeslot.startdate.cweek == Date.today.cweek) or (@booking.lemons >= 50)
          @timeslot.book_and_save(@booking)
          redirect_to resources_path(:b_dato => session[:b_dato]), :notice => "Tillykke! Rummet er dit"
        else
          redirect_to resources_path(:b_dato => session[:b_dato]), :notice => "Du har budt ind med #{@booking.lemons} frugter"
        end
      else
        booking_fruitbasket.destroy
        render action: 'new'
      end
    else
      redirect_to new_resource_timeslot_booking_path(@room, @timeslot), :notice => "Du har ikke nok frugter"
    end
  end

end