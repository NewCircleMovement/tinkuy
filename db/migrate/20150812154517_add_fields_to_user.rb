class AddFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :admin_info, :boolean, :default => false
  end
end
