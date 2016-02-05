class AddFruitsToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :fruits_per_month, :integer, :default => 0
  end
end
