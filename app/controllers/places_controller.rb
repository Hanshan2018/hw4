class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    #find the place to show
    @place = Place.find_by({ "id" => params["id"] })

    #find user that is logged in
    @user = User.find_by({ "id" => session["user_id"] })

    #only show entries if there is a user logged in - entries are associated with the user
    if @user != nil
      @entries = Entry.where({ "place_id" => @place["id"]}).where({"user_id" => session["user_id"]})
    else
    flash["notice"] = "Login first."
    end
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
