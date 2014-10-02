class AddEventIdToFruits < ActiveRecord::Migration
  def change
  	add_column :fruits, :event_id, :integer
  end
end
