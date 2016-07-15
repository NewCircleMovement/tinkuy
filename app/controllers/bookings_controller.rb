# == Schema Information
#
# Table name: bookings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  timeslot_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class BookingsController < ApplicationController
  before_filter :get_permission, only: [:new, :edit, :update, :destroy]

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

    if [@booking.lemons, 5].max <= current_user.fruitbasket.fruits_count
      # create fruitbasket for the booking
      booking_fruitbasket = Fruitbasket.create(:owner_id => @booking.id, :owner_type => 'Booking')
      
      if @booking.save
        # user gives fruit to booking
        current_user.fruitbasket.give_fruits_to( booking_fruitbasket, [@booking.lemons, 5].max )

        # book if booking is in current week or if fruits >= 50
        if (@timeslot.startdate.cweek == Date.today.cweek) or (@booking.lemons >= 50)
          @timeslot.book_and_save(@booking)
          redirect_to resource_path(@room, :b_dato => session[:b_dato]), :notice => "Tillykke! Rummet er dit"
        else
          redirect_to resource_path(@room, :b_dato => session[:b_dato]), :notice => "Du har budt ind med #{@booking.lemons} frugter"
        end
      else
        booking_fruitbasket.destroy
        render action: 'new'
      end
    else
      redirect_to new_resource_timeslot_booking_path(@room, @timeslot), :notice => "Du har ikke nok frugter"
    end
  end


  def update
    @room = Resource.find(params[:resource_id])
    @timeslot = Timeslot.find(params[:timeslot_id])
    @booking = Booking.find(params[:id])

    if @booking.update(params[:booking].permit(:user_id, :timeslot_id, :lemons))

      # user gives additional fruites to booking
      @increase = @booking.lemons - @booking.fruitbasket.fruits_count
      current_user.fruitbasket.give_fruits_to( @booking.fruitbasket, @increase)

      # book if fruits >= 50
      if @booking.lemons >= 50
        @timeslot.book_and_save(@booking)
        redirect_to resource_path(@room, :b_dato => session[:b_dato]), :notice => "Tillykke! Rummet er dit"
      else
        redirect_to resource_path(@room, :b_dato => session[:b_dato]), :notice => "Du har nu budt ind med #{@booking.lemons} frugter"
      end
    else
      render action: 'edit'
    end
  end  


  def destroy    
    @room = Resource.find(params[:resource_id])
    @booking = Booking.find(params[:id])
    @timeslot = @booking.timeslot

    if (Date.today <= @timeslot.startdate) and (Time.now.hour <= @timeslot.starttime.hour)
      @fruits = @booking.fruitbasket.fruits_count
      @booking.fruitbasket.give_fruits_to(current_user.fruitbasket, @fruits)
      
      @booking.destroy
      @timeslot.booked = false
      @timeslot.save!
      redirect_to resource_path(@room, :b_dato => session[:b_dato]), :notice => "Booking slettet. Du har fået #{@fruits} frugter tilbage"
    else
      redirect_to resource_path(@room, :b_dato => session[:b_dato]), :notice => "Du kan ikke slette bookinger i fortiden"
    end
  end

end
