# == Schema Information
#
# Table name: timeslots
#
#  id           :integer          not null, primary key
#  resource_id  :integer
#  startdate    :date
#  starttime    :time
#  duration     :integer
#  booked       :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#  day          :integer
#  is_recurring :boolean          default(FALSE)
#

class Timeslot < ActiveRecord::Base

  belongs_to :resource
  has_many :bookings, :dependent => :destroy

  def owner
    if recurring_booking
      user = recurring_booking.user
    elsif current_booking
      user = current_booking.user
    else
      user = "galt"
    end
    return user
  end


  def owner_first_name
    if recurring_booking
      user = recurring_booking.user.firstname
    elsif current_booking
      user = current_booking.user.firstname
    else
      user = "Admin"
    end
    return user
  end


  def score
    if self.current_booking.present?
      if self.current_booking.class == Booking
        return self.current_booking.fruitbasket.fruits_count
      else
        # TODO: this method will return 0 if the current booking is a recurring booking
        return 0
      end
    else
      return 0
    end
  end


  def minimum
    if self.bookings.count > 0
      return self.score + 5
    else
      return 5
    end
  end

  def current_booking
    fruits = 0
    
    self.bookings.each do |booking|
      if booking.fruitbasket.present?
        if booking.fruitbasket.fruits_count >= fruits
          @result = booking
          fruits = booking.fruitbasket.fruits_count
        end
      end
    end
    return @result
  end

  def recurring_booking
    # find om der eksisterer en recurring_booking med timeslottens dag og tid
    @result = RecurringBooking.where(:day => self.day, :time => self.starttime, :resource_id => self.resource_id).first
    if @result.present?
      return @result
    else
      return nil
    end
  end


  def book_and_save(booking)
    bids = self.bookings.where.not(id: booking.id)
    for bid in bids
      puts "#{bid.user.firstname} får #{bid.fruitbasket.fruits_count} frugter tilbage"
      bid.fruitbasket.give_fruits_to( bid.user.fruitbasket, bid.fruitbasket.fruits_count )
      bid.destroy
    end
    puts "#{booking.user.firstname} får ikke noget tilbage"

    self.booked = true
    self.save!
  end


  def schedule_book_and_save
    @booking = self.current_booking
    self.book_and_save(@booking)
  end


  def recurring_book_and_save( user )
    if self.current_booking.present?
      success = false
    else
      self.is_recurring = true
      self.booked = true
      self.save!
      success = true
    end
    return success
  end

  def can_be_booked
    if self.startdate >= Date.today
      return true
    else
      return false
    end
  end

end
