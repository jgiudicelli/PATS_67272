class VisitsController < ApplicationController
  def index
    # get all visits in reverse chronological order, 10 per page
    @visits = Visit.chronological.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
    # get the data for this particular visit
    @visit = Visit.find(params[:id])
    # get all the vaccinations associated with this visit, if any
    @vaccinations = @visit.vaccinations
  end
  
  def new
    @visit = Visit.new
  end
  
  def create
    @visit = Visit.new(params[:visit])
    if @visit.save
      flash[:notice] = "Successfully added visit for #{@visit.pet.name}."
      redirect_to @visit
    else
      render :action => 'new'
    end
  end
  
  def edit
    @visit = Visit.find(params[:id])
  end
  
  def update
    @visit = Visit.find(params[:id])
    if @visit.update_attributes(params[:visit])
      flash[:notice] = "Successfully updated visit by #{@visit.pet.name}."
      redirect_to @visit
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy
    flash[:notice] = "Successfully removed the visit of #{@visit.pet.name} on #{@visit.date.strftime('%b %e')}."
    redirect_to visits_url
  end
end
