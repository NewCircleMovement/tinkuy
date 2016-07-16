class AddTherapistDescriptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :therapist_description, :text
  end
end
