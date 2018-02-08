class InvitesController < ApplicationController
  def create
    recipient = User.find_by(email:params[:recipient])
    event = Event.find(params[:id])
    p 'USER', event.user
    if recipient && recipient != event.user
      attend = Attendee.where(user_id:recipient.id, event_id:params[:id])
      unless attend.first
        invited = Invite.where(user_id:recipient.id, event_id:params[:id])
        unless invited.first
          invite = Invite.new(user_id: recipient.id, event_id: params[:id], message: params[:message])
          if not invite.save
            invite.errors.each do |tag, error|
              flash[tag.to_sym] ||= []
              flash[tag.to_sym] << error
            end
          else
            flash[:recipient] =['has been successfully invited']
          end 
        else 
          flash[:recipient] = ['has already been sent an invite.']
        end 
      else 
        flash[:recipient] =['is already attending the event']
      end 
    else
      flash[:recipient] = ['doesn\'t exist. Invalid email provided.']
    end
    redirect_to :back
  end

  def destroy
    invite = Invite.where(user_id:session[:user_id], event_id:params[:id])
    if invite.first
      invite.first.destroy
      if params[:status] == '1'
        return redirect_to join_path(params[:id])
      end
    end
    redirect_to :back
  end
end
