class AddFruitCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fruits_count, :integer
  end
end
