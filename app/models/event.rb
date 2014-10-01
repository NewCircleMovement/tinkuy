# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  starttime   :time
#  week_number :integer
#  created_at  :datetime
#  updated_at  :datetime
#  startdate   :date
#  duration    :integer
#  hour        :integer
#  minute      :integer
#

class Event < ActiveRecord::Base
  
  belongs_to :user


  def my_week_day
    startdate.wday
  end

  def my_week
    startdate.strftime("%U").to_i
  end

end
