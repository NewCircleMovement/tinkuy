class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name
      t.integer :max_members

      t.timestamps
    end
  end
end
