class AnimalsController < ApplicationController

  def index
    @animals = Animal.all
  end

  def show
     # get data on that particular animal
      @animal = Animal.find(params[:id])
      # get all the pets of that animal type that have been treated by PATS
      @pets = Pet.by_animal(@animal.id).paginate(:page => params[:page]).per_page(10)
  end

  def new
    @animal = Animal.new
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def create
    @animal = Animal.new(params[:animal])
    if @animal.save
      flash[:notice] = "Successfully created animal."
      redirect_to @animal
    else
      render :action => 'new'
    end
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update_attributes(params[:animal])
      flash[:notice] = "Successfully updated animal."
      redirect_to @animal
    else
      render :action => 'edit'
    end
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    flash[:notice] = "Successfully destroyed animal."
    redirect_to animals_url
  end
end
