class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  # before_filter :active_user, only: [:new, :edit]
  before_filter :get_dates

  # GET /events
  # GET /events.json
  def index
    if session[:event_id].present?
      @new_event = Event.find(session[:event_id])
      session[:event_id] = nil
    end
    @events = Event.where(:confirmed => true).order(startdate: :asc, starttime: :asc)

    if params[:dato].present?
      session[:dato] = params[:dato].to_date
    end
    session[:next] = session[:dato] + 7.days
    session[:prev] = session[:dato] - 7.days

    @unconfirmed_events = Event.where(:confirmed => false).order(startdate: :asc, starttime: :asc)
    @top_events = Event.where(:confirmed => false).where("startdate >= ?", Date.today).order(fruits_count: :desc).limit(10)
    # @top_events = Event.joins(:fruits).group("fruits.event_id").order("count(fruits.event_id) desc").limit(10)
  end

  def suggestions
    # @events = Event.where(:confirmed => false).where("startdate >= ?", Date.today).order(fruits_count: :desc)
    @events = Event.where(:confirmed => false).where("startdate >= ?", Date.today).order(startdate: :asc)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @top_events = Event.where(:confirmed => false).where("startdate >= ?", Date.today).order(fruits_count: :desc).limit(10)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    if @event.save
      session[:event_id] = @event.id
      # redirect_to events_path(:event_id => id)
      redirect_to events_path
    else
      render action: 'new'
    end

    # respond_to do |format|
    #   if @event.save
    #     format.html { redirect_to @event, notice: 'Tak, dit forslag er nu registreret.' }
    #     format.json { render action: 'show', status: :created, location: @event }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @event.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Aktiviteten er nu blevet opdateret.' }
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
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def accept_fruit
    value = 1
    if current_user.fruits.where(:event_id => nil).count > 0
      @event = Event.find(params[:id])
      @fruit = current_user.fruits.where(:event_id => nil).first
      @fruit.event_id = @event.id
      @fruit.save!
      # @Fruit.create(:event_id => @event.id, :user_id => current_user.id)
      redirect_to :back, notice: "Tak for din stemme!"
    else
      redirect_to :back, notice: "Du har ikke flere frugter i denne måned"
    end
  end

  def get_dates
    session[:dato] = Date.today.beginning_of_week

    unless session[:is_new].present?
      session[:week_number] = Time.now.strftime("%V").to_i
    end
    session[:is_new] = "nej"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :duration, :starttime, :startdate, :hour, :minute)
      # params.require(:event).permit!
    end
end
