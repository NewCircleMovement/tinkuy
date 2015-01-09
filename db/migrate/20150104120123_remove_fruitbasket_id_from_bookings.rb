class RemoveFruitbasketIdFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :fruitbasket_id
  end
end
