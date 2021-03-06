# == Schema Information
#
# Table name: memberships
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  center_id        :integer
#  created_at       :datetime
#  updated_at       :datetime
#  max_members      :integer
#  price            :integer
#  fruits_per_month :integer          default(0)
#

class Membership < ActiveRecord::Base

  belongs_to :center
  
  has_many :users
  
  has_one :plan

end
