class RegistrationsController < Devise::RegistrationsController
  before_filter :get_plan, :only => [:new]


  def get_plan
    if session["new_plan"].present?
      @plan = Plan.find(session["new_plan"].to_i)
    end
  end

end