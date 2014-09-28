class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.date :startdate
      t.time :starttime

      t.timestamps
    end
  end
end
