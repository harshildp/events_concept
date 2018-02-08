class EventsController < ApplicationController
  def index
    @user = current_user
    zones = get_zones
    @events = Event.includes(:user).where('date >= ?', Date.current).order(:date).references(:user)
    @events = @events.reject{ |e| (e.date == Date.current && Time.parse(e.time.strftime("%H:%M")) - Time.parse(Time.now.getlocal(zones[e.state.to_sym]).strftime("%H:%M")) <= 0) || e.private == true}
    p 'EVENTs', @events
    @instate = @events.reject{ |e| e.state != @user.state }
    p 'INSTATE', @instate
    @outstate = @events.reject{ |e| e.state == @user.state }
    p 'OutSTATE', @outstate
    
    @states = get_states
  end

  def show
    @user = current_user
    @event = Event.includes(:user, :attendees).where(id:params[:id]).references(:user, :attendees)
    @event = @event.first if @event.first
    @comments = Comment.includes(:user).where(event_id:params[:id]).order(:created_at).references(:user)
  end

  def edit
    @user = current_user
    @event = Event.find(params[:id])
    @states = get_states
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = session[:user_id]
    if not @event.save
      @event.errors.each do |tag, error|
        flash[tag.to_sym] ||= []
        flash[tag.to_sym] << error
      end
      flash[:newEvent] = ['creatin']
    end
    redirect_to events_path
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to show_event_path(@event.id)
    else 
      @event.errors.each do |tag, error|
        flash[tag.to_sym] ||= []
        flash[tag.to_sym] << error
      end
      redirect_to edit_event_path
    end   
  end 

  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event
    if params[:page]
      redirect_to events_path
    else
      redirect_to :back
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :location, :state, :date, :time, :description, :private)
    end    
end
