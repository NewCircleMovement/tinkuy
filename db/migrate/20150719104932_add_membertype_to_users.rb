class AddMembertypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membertype, :integer
  end
end
