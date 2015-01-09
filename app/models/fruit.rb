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

class Fruit < ActiveRecord::Base
  # attr_accessible :event_id

  belongs_to :event, counter_cache: true
 
  belongs_to :user
  belongs_to :fruitbasket, counter_cache: true

end
