class RegistrationsController < Devise::RegistrationsController
  before_filter :get_plan, :only => [:new]
  # before_filter :check_if_full

  def update
    update_method = :update_without_password
    permit_fields = [:therapist_description, :firstname, :surname, :email]

    if not resource_params["password"].empty?
      update_method = :update_with_password
      permit_fields = permit_fields + [:password, :current_password, :password_confirmation]
    end

    update_params = resource_params.permit(permit_fields)

    respond_to do |format|
      if @user.send(update_method, update_params)
        format.html { redirect_to edit_user_registration_path, notice: 'Profil opdateret.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_plan
    if session["new_plan"].present?
      @plan = Plan.find(session["new_plan"].to_i)

      if @places_left == false
        unless @plan.membership.name == 'SUPPORTER'
          redirect_to root_url, :notice => "Der er ingen pladser tilbage"
        end
      end  
    
    end
  end

  # def destroy
  #   super
  #   @subscription.plan_id = nil
  #   @subscription.save
  #   redirect_to owner_subscription_path(@owner, @subscription)
  # end

  # def check_if_full
  #   # if @places_left == false
  #     unless @plan.membership.name == 'SUPPORTER'
  #       redirect_to root_url, :notice => "Der er ingen pladser tilbage"
  #     end
  #   # end
  # end

end
