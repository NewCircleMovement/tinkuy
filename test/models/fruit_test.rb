# == Schema Information
#
# Table name: fruits
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  event_id       :integer
#  fruitbasket_id :integer
#

require 'test_helper'

class FruitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
