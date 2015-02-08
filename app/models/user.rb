# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  firstname              :string(255)
#  surname                :string(255)
#  confirm_payment        :boolean          default(FALSE)
#  status                 :string(50)       default("pending")
#  admin                  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :firstname, :surname, :email, :presence => true
    
  has_many :events
  has_many :votes
  has_many :bookings, :dependent => :destroy
  has_many :fruits, :dependent => :destroy
  has_many :recurring_bookings, :dependent => :destroy
  has_one :fruitbasket, as: :owner, :dependent => :destroy
  has_one :subscription, :dependent => :destroy

  after_create :create_fruitbasket

  def create_fruitbasket
    @fruitbasket = Fruitbasket.create(:owner_id => self.id, :owner_type => 'User')
    100.times do
      Fruit.create(:user_id => self.id, :fruitbasket_id => @fruitbasket.id)
    end
  end

  def has_voted_on(event)
    for vote in event.votes do
      if self.id == vote.user_id
        return true
      end
    end
    return false
  end

  def can_book_recurring
    if self.subscription.present?
      if [3,4].include? self.subscription.plan_id
        result = true
      else
        result = false
      end
    else
      result = false
    end
    return result
  end

  def has_max_recurring_bookings
    rec_bookings = self.recurring_bookings.length
    
    if rec_bookings == self.subscription.plan.max_recur_bookings
      result = true
    else
      result = false
    end
    return result
  end

  def can_upgrade
    max_plan = Plan.order(:price).last
    if self.subscription.plan == max_plan
      result = false
    else
      result = true
    end
    return result
  end

  def is_bank_member
    if ['pending', 'active'].include? self.status and self.subscription == nil
      return true
    else
      return false
    end
  end

end
