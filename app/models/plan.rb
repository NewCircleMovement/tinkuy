# == Schema Information
#
# Table name: plans
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  stripe_id          :string(255)
#  price              :float
#  interval           :string(255)
#  features           :text
#  highlight          :boolean
#  display_order      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  max_recur_bookings :integer
#  fruits_per_month   :integer
#  description        :text
#  max_members        :integer
#  membership_id      :integer
#

class Plan < ActiveRecord::Base
  has_many :subscriptions

  include Koudoku::Plan
  
  belongs_to :membership
  belongs_to :user
  belongs_to :coupon

end
