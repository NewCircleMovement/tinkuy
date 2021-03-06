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
  
  has_one :fruitbasket, as: :owner

  def week_number
    startdate.beginning_of_week(start_day = :monday).strftime("%V").to_i
  end

  def user_name

    if user.present?
      firstname, surname = '', ''
      if user.firstname.present?
        firstname = user.firstname
      end

      if user.surname.present?
        surname = ' ' + user.surname
      end
      return (firstname + surname).strip()
    else
      return 'NO OWNER'
    end
    
  end

end
