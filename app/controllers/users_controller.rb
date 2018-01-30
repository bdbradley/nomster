class UsersController < ApplicationController
#takes the id from the URL. looks up user in database and puts value in user variable
  def show
    @user = User.find(params[:id])
    
  end
end
