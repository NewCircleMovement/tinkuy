class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_spaces, :integer
    add_column :events, :free_spaces, :integer
  end
end
