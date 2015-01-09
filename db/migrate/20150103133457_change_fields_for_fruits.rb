class ChangeFieldsForFruits < ActiveRecord::Migration
  def change
    add_column :fruits, :fruitbasket_id, :integer
  end
end
