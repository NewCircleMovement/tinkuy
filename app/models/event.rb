# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  starttime   :datetime
#  week_number :integer
#  created_at  :datetime
#  updated_at  :datetime
#  startdate   :date
#  duration    :integer
#

class Event < ActiveRecord::Base
  
  #def self.on_day
   # where("DATE(startdate) = DATE(?)", DateTime.now.beginning_of_week)
  #end

  def my_week_day
    startdate.wday
  end

  def my_week
    startdate.strftime("%U").to_i
  end

end
