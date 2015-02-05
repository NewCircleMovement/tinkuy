# == Schema Information
#
# Table name: plans
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  stripe_id     :string(255)
#  price         :float
#  interval      :string(255)
#  features      :text
#  highlight     :boolean
#  display_order :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Plan < ActiveRecord::Base
  has_many :subscriptions

  include Koudoku::Plan
  
  belongs_to :user
  belongs_to :coupon

end
