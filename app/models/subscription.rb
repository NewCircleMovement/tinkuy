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
  after_create :update_membership
  after_update :update_membership

  include Koudoku::Subscription

  belongs_to :user
  belongs_to :coupon

  def update_membership

    if self.plan_id.present?
      user = self.user  
      plan = Plan.find(plan_id)
      user.membership_id = plan.membership.id
      user.save!
    end
  end

end
