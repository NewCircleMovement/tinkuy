class CreateFruitbaskets < ActiveRecord::Migration
  def change
    create_table :fruitbaskets do |t|
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end
