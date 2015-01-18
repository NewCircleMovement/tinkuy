# == Schema Information
#
# Table name: timeslots
#
#  id          :integer          not null, primary key
#  resource_id :integer
#  startdate   :date
#  starttime   :time
#  duration    :integer
#  booked      :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class Timeslot < ActiveRecord::Base

  belongs_to :resource
  has_many :bookings, :dependent => :destroy


  def owner
    if current_booking
      return current_booking.user
    else
      return "galt"
    end
  end

  def score
    if self.current_booking.present?
      return self.current_booking.fruitbasket.fruits_count
    else
      return 0
    end
  end

  def minimum
    return self.score + 5
  end

  def current_booking
    fruits = 0
    self.bookings.each do |booking|
      if booking.fruitbasket.present?
        if booking.fruitbasket.fruits_count > fruits
          @result = booking
          fruits = booking.fruitbasket.fruits_count
        end
      end
    end
    return @result
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

  
end
