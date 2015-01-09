# == Schema Information
#
# Table name: fruitbaskets
#
#  id           :integer          not null, primary key
#  owner_id     :integer
#  owner_type   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  fruits_count :integer          default(0)
#

require 'test_helper'

class FruitbasketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
