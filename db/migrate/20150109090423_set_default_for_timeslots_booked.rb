class SetDefaultForTimeslotsBooked < ActiveRecord::Migration
  def change
    change_column :timeslots, :booked, :boolean, default: false
  end
end
