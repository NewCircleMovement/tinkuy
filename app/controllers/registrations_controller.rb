class RegistrationsController < Devise::RegistrationsController
  before_filter :get_plan, :only => [:new]
  before_filter :check_if_full


  def get_plan
    if session["new_plan"].present?
      @plan = Plan.find(session["new_plan"].to_i)
    end
  end

  # def destroy
  #   super
  #   @subscription.plan_id = nil
  #   @subscription.save
  #   redirect_to owner_subscription_path(@owner, @subscription)
  # end

  def check_if_full
    if @places_left <= 0
      redirect_to root_url, :notice => "Der er ingen pladser tilbage"
    end
  end

end