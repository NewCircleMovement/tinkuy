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

require 'test_helper'

class TimeslotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
