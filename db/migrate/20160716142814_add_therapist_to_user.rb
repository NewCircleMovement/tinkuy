class AddTherapistToUser < ActiveRecord::Migration
  def change
    add_column :users, :therapist, :boolean, :default => false
  end
end
