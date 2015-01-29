class AddResourceToRecurringBookings < ActiveRecord::Migration
  def change
    add_column :recurring_bookings, :resource_id, :integer
  end
end
