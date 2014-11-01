# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :string(255)
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
#

class Event < ActiveRecord::Base
  belongs_to :user
  has_many :fruits

  after_create :fruit_donation

  validates :startdate, :presence => true
  validates :starttime, :presence => true


  def week_number
    startdate.beginning_of_week(start_day = :monday).strftime("%V").to_i
  end

  def fruit_donation
    Fruit.create(:event_id => self.id)
  end

end
