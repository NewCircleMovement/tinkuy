class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.integer :resource_id
      t.date :startdate
      t.time :starttime
      t.integer :duration
      t.boolean :booked

      t.timestamps
    end
  end
end
