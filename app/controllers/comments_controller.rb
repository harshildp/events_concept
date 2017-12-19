class CommentsController < ApplicationController
  def create
    @comment = Comment.new(content: params[:content])
    @comment.user_id = session[:user_id]
    @comment.event_id = params[:id] 
    if not @comment.save
      @comment.errors.each do |tag, error|
        flash[tag.to_sym] ||= []
        flash[tag.to_sym] << error
      end
    end
    redirect_to show_event_path(params[:id])
  end
end
