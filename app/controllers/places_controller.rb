  class PlacesController < ApplicationController

  def index
    @places = Place.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @place = Place.new
  end
  
  def create
      Place.create(place_params)
      redirect_to root_path
  end

  private
#Says that user f.input created in new.html.erb is permitted and required  
  def place_params
    params.require(:place).permit(:name, :description, :address)

  end
end
