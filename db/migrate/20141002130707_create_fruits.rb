class CreateFruits < ActiveRecord::Migration
  def change
    create_table :fruits do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
