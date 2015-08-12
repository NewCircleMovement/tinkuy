class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :amount
      t.string :category

      t.timestamps
    end
  end
end
