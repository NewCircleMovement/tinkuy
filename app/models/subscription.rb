# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  stripe_id     :string(255)
#  plan_id       :integer
#  last_four     :string(255)
#  coupon_id     :integer
#  card_type     :string(255)
#  current_price :float
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Subscription < ActiveRecord::Base
  include Koudoku::Subscription

  
  belongs_to :user
  belongs_to :coupon

end
