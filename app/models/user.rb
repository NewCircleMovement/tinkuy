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
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :confirm_payment, :acceptance => {:accept => true}
  validates :firstname, :surname, :presence => true
    
  has_many :events
  has_many :bookings
  has_many :fruits
  has_one :fruitbasket, as: :owner

  # after_create :create_fruitbasket

  # def create_fruitbasket
  #   fruitbasket = Fruitbasket.create(:owner_id => self.id, :owner_type => 'User')
  #   100.times do
  #     Fruit.create(:user_id => self.id, :fruitbasket_id => fruitbasket.id)
  #   end
  # end

end
