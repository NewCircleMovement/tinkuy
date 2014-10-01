class AddExtraColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :firstname, :string
  	add_column :users, :surname, :string
    add_column :users, :active, :boolean, :default => false
    add_column :users, :pending, :boolean, :default => true
    add_column :users, :confirm_payment, :boolean, :default => false
  end
end
