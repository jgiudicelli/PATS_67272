class VaccinesController < ApplicationController
  def index
    # get data on all vacines offered by PATS, 10 per page
    @vaccines = Vaccine.alphabetical.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
    # get the data on this particular vaccine
    @vaccine = Vaccine.find(params[:id])
  end
  
  def new
    @vaccine = Vaccine.new
  end
  
  def create
    @vaccine = Vaccine.new(params[:vaccine])
    if @vaccine.save
      flash[:notice] = "Successfully added #{@vaccine.name} for #{@vaccine.animal.name} to PATS."
      redirect_to @vaccine
    else
      render :action => 'new'
    end
  end
  
  def edit
    @vaccine = Vaccine.find(params[:id])
  end
  
  def update
    @vaccine = Vaccine.find(params[:id])
    if @vaccine.update_attributes(params[:vaccine])
      flash[:notice] = "Successfully updated #{@vaccine.name} for #{@vaccine.animal.name}."
      redirect_to @vaccine
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @vaccine = Vaccine.find(params[:id])
    @vaccine.destroy
    flash[:notice] = "Successfully destroyed #{@vaccine.name} for #{@vaccine.animal.name}."
    redirect_to vaccines_url
  end
end
