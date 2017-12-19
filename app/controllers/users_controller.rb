class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :auth, except: [:new, :create]

  def new
    @states = get_states
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to events_path
    else 
      @user.errors.each do |tag, error|
        flash[tag.to_sym] ||= []
        flash[tag.to_sym] << error
      end
      flash[:register] = ["registerin"]
      redirect_to signin_path
    end
  end

  def edit
    @user = current_user
    @states = get_states
  end

  def update
    @user = User.find(session[:user_id])
      if @user.update(update_params)
        redirect_to events_path
      else 
        @user.errors.each do |tag, error|
          flash[tag.to_sym] ||= []
          flash[tag.to_sym] << error
        end
        redirect_to edit_user_path
      end   
  end

  def show
    @user = User.includes(:invites).where(id:session[:user_id]).references(:invites).first
    @created = Event.includes(:user).where('date >= ?', Date.current).order(:date).references(:user)
    @created = @created.select{|e| e.user == @user}
    @created = @created.reject{|e| e.date == Date.current && (Time.parse(e.time.strftime("%H:%M")) - Time.parse(Time.now.getlocal("-06:00").strftime("%H:%M"))) < 0 }
    p 'Created', @created
    @attending = Event.includes(:user, :attendees).where('attendees.user_id = ?', @user.id).order(:date).references(:user, :attendees)
    @attending = @attending.select{|e| e.date >= Date.current }
    @attending = @attending.reject{ |e| e.date == Date.current && Time.parse(e.time.strftime("%H:%M")) - Time.parse(Time.now.getlocal("-06:00").strftime("%H:%M")) < 0 }
    p 'ATTENDING', @attending
  end

  private
    def auth 
      redirect_to events_path unless params[:id] == session[:user_id].to_s
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
    end  
    def update_params
      params.require(:user).permit(:first_name, :last_name, :email, :location, :state)
    end     
end
