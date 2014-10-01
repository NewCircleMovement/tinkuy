class ChangeColumnTypeInEvents < ActiveRecord::Migration
  def change
  	change_column :events, :starttime, :time
  end
end
