# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  duration    :integer
#

class Resource < ActiveRecord::Base
  validates :duration, :presence => :true

  has_many :timeslots
  has_many :recurring_bookings

end
