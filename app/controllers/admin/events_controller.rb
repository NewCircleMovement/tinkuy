class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:edit, :update, :destroy]

  def index
    events = Event.includes(:fruitbasket).includes(:votes).order(startdate: :asc, starttime: :asc)
    @confirmed_events = events.where(:confirmed => true)
    
    if params[:old] == 'yes'
      @confirmed_events = @confirmed_events.where("startdate < ?", Date.today)
    else
      @confirmed_events = @confirmed_events.where("startdate >= ?", Date.today)
    end
    
    @unconfirmed_events = events.where(:confirmed => false).where("startdate >= ?", Date.today)
  end

  # GET /events/1/edit
  def edit
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to admin_events_path, notice: 'Aktiviteten er nu blevet opdateret.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_path , notice: "Aktiviteten er nu slettet."}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :duration, :starttime, :startdate, :confirmed, :user_id)
    end  

end
