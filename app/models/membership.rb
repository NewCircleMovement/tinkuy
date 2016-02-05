class Membership < ActiveRecord::Base

  belongs_to :center
  
  has_many :users
  
  has_one :plan

end
