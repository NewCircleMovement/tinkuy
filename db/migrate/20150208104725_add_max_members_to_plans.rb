class AddMaxMembersToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :max_members, :integer
  end
end
