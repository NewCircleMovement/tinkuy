class Admin::CentersController < Admin::BaseController
  before_action :set_center, only: [:edit, :update, :destroy]
  
  def index
    @centers = Center.all
  end

  def new
    @center = Center.new
  end

  def edit
  end

  def create
    @center = Center.new(center_params)

    respond_to do |format|
      if @center.save
        format.html { redirect_to admin_centers_path, notice: 'Center was successfully created.' }
        format.json { render action: 'show', status: :created, location: @center }
      else
        format.html { render action: 'new' }
        format.json { render json: @center.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @center.update(center_params)
        format.html { redirect_to admin_centers_path, notice: 'Brugeren blev opdateret.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @center.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @center.destroy
    redirect_to admin_centers_path, notice: 'Brugeren blev slettet' 
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_center
      @center = Center.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def center_params
      params.require(:center).permit(:name, :max_members)
    end
end
