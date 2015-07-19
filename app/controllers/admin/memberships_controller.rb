class Admin::MembershipsController < Admin::BaseController
  before_action :set_membership, only: [:edit, :update, :destroy]
  
  def index
    @memberships = Membership.all.order(:id)
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      redirect_to admin_memberships_path, notice: 'Medlemskabet blev oprettet'
    else
      render action: 'new'
    end

  end

  def edit

  end

  def update
    if @membership.update(membership_params)
      redirect_to admin_memberships_path, notice: 'Medlemsskabet blev opdateret.'
      
    else
      render action: 'edit'
    
    end
  end

  def destroy
    @membership.destroy
    redirect_to admin_memberships_path, notice: 'Medlemskabet blev slettet' 
  end

  
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:id, :name, :center_id, :max_members)
    end
end
