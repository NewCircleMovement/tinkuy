class ChangeTimeInEvents < ActiveRecord::Migration
  def change
  	change_column :events, :starttime, :datetime
  end
end
