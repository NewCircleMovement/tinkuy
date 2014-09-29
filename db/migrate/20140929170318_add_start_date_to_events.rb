class AddStartDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :startdate, :date
  end
end
