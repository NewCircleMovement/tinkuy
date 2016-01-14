class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index

    focus = 'active'
    if params[:focus].present?
      focus = params[:focus]
    end
    params[:focus] = focus

    @users = User.where(:status => focus).includes(:subscription).includes(:fruitbasket).order(:firstname, :surname)

    criteria = Time.now
    if params[:filter].present?
      criteria = criteria - params[:days].to_i.days
      if params[:filter] == 'new'
        @users = @users.where(["created_at >= ?", criteria]).order(:created_at)
      end
      if params[:filter] == 'goodbye'
        @users = @users.where(["updated_at >= ?", criteria]).order(:updated_at)
      end
    end

  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'Brugeren blev opdateret.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'Brugeren blev slettet' 
  end

  
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :surname, :status, :membership_id)
      # params.require(:user).permit!
    end
end
