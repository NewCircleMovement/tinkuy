class AddStartDateToRecurringBookings < ActiveRecord::Migration
  def change
    add_column :recurring_bookings, :startdate, :date
  end
end
