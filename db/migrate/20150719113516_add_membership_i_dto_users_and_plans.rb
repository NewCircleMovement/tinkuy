class AddMembershipIDtoUsersAndPlans < ActiveRecord::Migration
  def change
  	add_column :users, :membership_id, :integer
  	add_column :plans, :membership_id, :integer
  end
end
