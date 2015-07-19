class Admin::PlansController < Admin::BaseController
  before_action :set_plan, only: [:edit, :update, :destroy]
  
  def index
    @plans = Plan.all.order(:id)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to admin_plans_path, notice: 'Medlemskabet blev oprettet'
    else
      render action: 'new'
    end

  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      redirect_to admin_plans_path, notice: 'Medlemsskabet blev opdateret.'
      
    else
      render action: 'edit'
    
    end
  end

  def destroy
    @plan.destroy
    redirect_to admin_plans_path, notice: 'Medlemskabet blev slettet' 
  end

  
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:id, :name, :membership_id, :price, :interval, :max_members, :stripe_id, :features, :display_order, :highlight, :max_recur_bookings, :fruits_per_month, :description)
    end
end
