class VaccinationsController < ApplicationController

  def index
    # get all the data on vaccinations in the system, 10 per page
    @vaccinations = Vaccination.all.chronological.page(params[:page]).per_page(10)
  end

  def show
    # get information on this particular vaccination
    @vaccination = Vaccination.find(params[:id])
  end

  def new
    @vaccination = Vaccination.new
  end

  def edit
    @vaccination = Vaccination.find(params[:id])
  end

  def create
    @vaccination = Vaccination.new(params[:vaccination])
    if @vaccination.save
      flash[:notice] = "Successfully created vaccination."
      redirect_to @vaccination
    else
      render :action => 'new'
    end
  end

  def update
    @vaccination = Vaccination.find(params[:id])
    if @vaccination.update_attributes(params[:vaccination])
      flash[:notice] = "Successfully updated vaccination."
      redirect_to @vaccination
    else
      render :action => 'edit'
    end
  end

  def destroy
    @vaccination = Vaccination.find(params[:id])
    @vaccination.destroy
    flash[:notice] = "Successfully destroyed vaccination."
    redirect_to vaccinations_url
  end
end
