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

module EventsHelper

  

end
