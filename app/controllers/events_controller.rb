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

  
  def edit
  end

  
  def create
    @event = Event.new(event_params)

    if @event.save
      session[:event_id] = @event.id
      redirect_to events_path
    else
      render action: 'new'
    end
  end


  def update
    if @event.update(event_params)
      redirect_to events_path, notice: 'Aktiviteten er nu blevet opdateret.'
    else
      render action: 'edit'
    end
  end


  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def upvote
    @event = Event.find(params[:id])

    unless current_user.has_voted_on(@event)
      @vote = Vote.create(:event_id => @event.id, :user_id => current_user.id)
      @vote.save!
      redirect_to :back, notice: "Tak for din stemme!"
    else
      redirect_to :back, notice: "Du har allerede stemt"
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
      params.require(:event).permit(:name, :description, :duration, :starttime, :startdate, :hour, :minute, :user_id, :confirmed)
      # params.require(:event).permit!
    end
end
