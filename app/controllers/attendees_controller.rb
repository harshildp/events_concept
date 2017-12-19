class AttendeesController < ApplicationController
  def create
    @attendee = Attendee.create(event_id: params[:id], user_id: session[:user_id])
    redirect_to :back
  end

  def destroy
    @attendee = Attendee.where(event_id: params[:id], user_id: session[:user_id])
    @attendee.first.destroy if @attendee.first
    redirect_to :back
  end
end
