class AddHourAndMinuteToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :hour, :integer
  	add_column :events, :minute, :integer
  end
end
