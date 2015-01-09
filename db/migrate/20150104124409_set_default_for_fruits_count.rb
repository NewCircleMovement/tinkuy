class SetDefaultForFruitsCount < ActiveRecord::Migration
  def change
    change_column :fruitbaskets, :fruits_count, :integer, default: 0
  end
end
