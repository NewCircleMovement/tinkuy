class AddMemberMaxToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :max_members, :integer
  end
end
