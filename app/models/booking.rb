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

class Booking < ActiveRecord::Base
  attr_accessor :lemons

  belongs_to :timeslot
  belongs_to :user
  has_one :fruitbasket, as: :owner, :dependent => :destroy

  def lemons=(new_value)
    @lemons = new_value.to_i
  end

  def lemons
    @lemons
  end

end
