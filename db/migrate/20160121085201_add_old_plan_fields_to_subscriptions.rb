class AddOldPlanFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :old_plan_id, :integer, :default => nil
    add_column :subscriptions, :old_plan_exit_date, :date, :default => nil
  end
end
