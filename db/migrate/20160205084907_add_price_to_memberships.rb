class AddPriceToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :price, :integer
  end
end
