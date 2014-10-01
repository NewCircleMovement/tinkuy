# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  starttime   :time
#  week_number :integer
#  created_at  :datetime
#  updated_at  :datetime
#  startdate   :date
#  duration    :integer
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
