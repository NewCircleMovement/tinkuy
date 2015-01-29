class AddDayToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :day, :integer
  end
end
