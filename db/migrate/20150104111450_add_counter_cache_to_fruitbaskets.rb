class AddCounterCacheToFruitbaskets < ActiveRecord::Migration
  def change
    add_column :fruitbaskets, :fruits_count, :integer
  end
end
