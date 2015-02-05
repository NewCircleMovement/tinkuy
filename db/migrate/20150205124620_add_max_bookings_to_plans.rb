class AddMaxBookingsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :max_recur_bookings, :integer
    add_column :plans, :fruits_per_month, :integer
    add_column :plans, :description, :text
  end
end
