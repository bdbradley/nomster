class CommentsController < ApplicationController
  #Requires user to be logged in
  before_action :authenticate_user!

  def create
    #Pulls place_id out of the URL
    @place = Place.find(params[:place_id])
    @place.comments.create(comment_params.merge(user: current_user))
    redirect_to place_path(@place)
  end

  private
  #pull data out of comment form
  def comment_params
    params.require(:comment).permit(:message, :rating)
  end
end
