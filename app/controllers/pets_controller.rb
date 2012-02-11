class PetsController < ApplicationController

  respond_to :html, :xml, :json
  
  def index
    # get data on all pets and paginate the output to 10 per page
    @pets = Pet.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    respond_with @pets

  end

  def show
    # get the data for this particular pet
    @pet = Pet.find(params[:id])
    # get the last 10 visits for this pet
    @recent_visits = @pet.visits.all.last(10)
    respond_with @pet
  end

  def new
    @pet = Pet.new
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def create
    @pet = Pet.new(params[:pet])
    if @pet.save
      redirect_to @pet, :notice => "Successfully added #{@pet.name} as a PATS pet."
    else
      render :action => 'new'
    end
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update_attributes(params[:pet])
      redirect_to @pet, :notice => "Updated #{@pet.name}'s information"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_url, :notice => "Removed #{@pet.name} from the PATS system"
  end
end
