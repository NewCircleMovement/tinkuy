class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :starttime
      t.integer :week_number

      t.timestamps
    end
  end
end
