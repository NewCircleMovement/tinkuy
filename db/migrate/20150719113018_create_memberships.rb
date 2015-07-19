class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.integer :center_id

      t.timestamps
    end
  end
end
