# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  amount     :integer
#  category   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bid < ActiveRecord::Base
end
