class AddStatusToUsers < ActiveRecord::Migration
  def up
    add_column :users, :status, :string, :limit => 50, :default => 'pending'

    User.all.each do |user|
    	if user.active == true && user.pending == false
    		user.update_column(:status, 'active')
    	end
    end
    remove_column :users, :active
    remove_column :users, :pending
  end


  def down
  	add_column :users, :active, :boolean, :default => false
    add_column :users, :pending, :boolean, :default => true

    User.all.each do |user|
    	if user.status == 'active'
    		user.update_columns(active: true, pending: false)
    	elsif user.status == 'pending'
    		user.update_columns(active: false, pending: true)
    	end
    end
    remove_column :users, :status
  end
end
