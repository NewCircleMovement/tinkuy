# == Schema Information
#
# Table name: recurring_bookings
#
#  id          :integer          not null, primary key
#  day         :integer
#  time        :time
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  startdate   :date
#  resource_id :integer
#

class RecurringBooking < ActiveRecord::Base

  # validates :uniqueness => {:scope => [:day, :time]}
  validates :day, :time, :user_id, :resource_id, :startdate, :presence => true

  belongs_to :user
  belongs_to :resource

end
