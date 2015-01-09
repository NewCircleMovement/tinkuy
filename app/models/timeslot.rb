# == Schema Information
#
# Table name: timeslots
#
#  id          :integer          not null, primary key
#  resource_id :integer
#  startdate   :date
#  starttime   :time
#  duration    :integer
#  booked      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

class Timeslot < ActiveRecord::Base

  belongs_to :resource
  has_many :bookings, :dependent => :destroy


  def owner
    return current_booking.user.firstname
  end

  def score
    return current_booking.fruitbasket.fruits_count
  end

  def current_booking
    score = 0
    for booking in self.bookings
      if booking.fruitbasket.fruits_count > score
        result = booking
        score = booking.fruitbasket.fruits_count
      end
    end
    return result
  end

  def book_and_save
    booking = current_booking

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
  
end
