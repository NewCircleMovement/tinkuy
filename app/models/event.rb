# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  starttime    :time
#  week_number  :integer
#  created_at   :datetime
#  updated_at   :datetime
#  startdate    :date
#  duration     :integer
#  hour         :integer
#  minute       :integer
#  confirmed    :boolean          default(FALSE)
#  user_id      :integer
#  fruits_count :integer
#  max_spaces   :integer
#  free_spaces  :integer
#

class Event < ActiveRecord::Base
  validates :startdate, :presence => true
  validates :starttime, :presence => true
  validates :user_id, :presence => true
  
  belongs_to :user

  has_many :votes, :dependent => :destroy
  
  has_many :bids, :dependent => :destroy
  has_many :users, :through => :bids
  
  has_one :fruitbasket, as: :owner

  def week_number
    startdate.beginning_of_week(start_day = :monday).strftime("%V").to_i
  end


  def request_signup(user)
    # puts "////////////////////////// #{user.id}"
    # puts "/////// #{self.id}"

    # bid = Bid.new(:event_id => 1, :user_id => 20)
    # bid = Bid.find_or_create_by(:event_id => id, :user_id => user.id)
    # Bid.find_or_create_by(:event_id => id, :user_id => user.id)
    # bid = Bid.where(:event_id => self.id, :user_id => user.id).first
    # bid.amount = 200
    puts "///////////////////////////////////////////"
    # # puts bid
    # # puts bid.event_id
    # # puts bid.user_id
    # # bid = Bid.new(:event_id => id, :user_id => user.id)
    # bid.save
    # bid = Bid.find_or_create_by(:event_id => id, :user_id => user.id)

  end

end
