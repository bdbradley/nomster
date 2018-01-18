  class PlacesController < ApplicationController
    #With before_action only a logged in user can access the new, create etc methods
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
        #Allows a before filter which only lets logged in users
        #access 'new' and 'create'. Users not logged in will be directed
        #to the login in page when clicking on 'new place'
      before_action :authenticate_user!, only: [:new, :create]
  def index
    @places = Place.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @place = Place.new
  end
  #Runs when the create button pressed on the form
  def create
      #Place.create(place_params)
      #Creates a place connected with the user. Knows this bc of has_many :places
      #in the user.rb file and sets it to @place
      @place = current_user.places.create(place_params)
      #if place valid, go to root_path, else go to the new form again and throw validation error
      if @place.valid?
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
  end

def show
  #apparently loads the Place id into the variable @place to be
  #passed to the show.html.erb view file so the place name a user
  #clicks on will show up on the page
  @place = Place.find(params[:id])
  @comment = Comment.new
end

def edit
  @place = Place.find(params[:id])
  #Only the current user that's signed in can access and edit their places
  if @place.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end
end

def update
  @place = Place.find(params[:id])
  #Only the current user that's signed in can access and update their places, returns 'not allowed' error
  if @place.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end

  @place.update_attributes(place_params)
  #if place valid, go to root_path, else go to the edit form again and throw validation error
  if @place.valid?
    redirect_to root_path
  else
    render :edit, status: :unprocessable_entity
  end
end
#def destroy will trigger destroy in show.html.erb
def destroy
  #finds the :id of the place 
  @place = Place.find(params[:id])
  #Display error message if user tries to destroy place they haven't created
  if @place.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end
  #destroys the found place
  @place.destroy
  #this directs user back to root_path
  redirect_to root_path
end

    private
#Says that user f.input created in new.html.erb is permitted and required  
  def place_params
    params.require(:place).permit(:name, :description, :address)

  end
end
