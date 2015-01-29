class AddIsRecurringToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :is_recurring, :boolean, :default => false
  end
end
