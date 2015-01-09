class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :fruitbasket_id
      t.integer :timeslot_id

      t.timestamps
    end
  end
end
