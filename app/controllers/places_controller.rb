  class PlacesController < ApplicationController
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
      #in the user.rb file
      current_user.places.create(place_params)
      redirect_to root_path
  end

def show
  #apparently loads The Place id into the variable @place to be
  #passed to the show.html.erb view file so the place name a user
  #clicks on will show up on the page
  @place = Place.find(params[:id])
end

def edit
  @place = Place.find(params[:id])
end

def update
  @place = Place.find(params[:id])
  @place.update_attributes(place_params)
  redirect_to root_path
end

    private
#Says that user f.input created in new.html.erb is permitted and required  
  def place_params
    params.require(:place).permit(:name, :description, :address)

  end
end
