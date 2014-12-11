class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
    @confirmed_users = User.where(:status => 'active').order(:firstname, :surname)
    @pending_users = User.where(:status => 'pending').order(:firstname, :surname)
    @passive_users = User.where(:status => 'passive').order(:firstname, :surname)
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
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'Brugeren blev slettet' }
      format.json { head :no_content }
    end
  end

  
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :surname, :status)
      # params.require(:user).permit!
    end
end
