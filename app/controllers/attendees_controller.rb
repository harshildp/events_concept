class AttendeesController < ApplicationController
  def create
    @invite= Invite.where(event_id:params[:id], user_id: session[:user_id])
    @attendee = Attendee.create(event_id: params[:id], user_id: session[:user_id])
    @invite.first.destroy if @invite.first    
    redirect_to :back
  end

  def destroy
    @attendee = Attendee.where(event_id: params[:id], user_id: session[:user_id])
    @attendee.first.destroy if @attendee.first
    redirect_to :back
  end
end
