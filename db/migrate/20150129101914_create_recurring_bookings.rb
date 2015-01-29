class CreateRecurringBookings < ActiveRecord::Migration
  def change
    create_table :recurring_bookings do |t|
      t.integer :day
      t.time :time
      t.integer :user_id

      t.timestamps
    end
  end
end
