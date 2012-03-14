class OwnersController < ApplicationController

  def index
    # finding all the active owners and paginating that list (will_paginate)
    @owners = Owner.active.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @owner = Owner.find(params[:id])
    # get all the pets for this owner
    @current_pets = @owner.pets.active.all
  end

  def new
    @owner = Owner.new
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def create
    @owner = Owner.new(params[:owner])
    if @owner.save
      # if saved to database
      flash[:notice] = "Successfully created #{@owner.proper_name}."
      redirect_to @owner # go to show owner page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(params[:owner])
      flash[:notice] = "Successfully updated #{@owner.proper_name}."
      redirect_to @owner
    else
      render :action => 'edit'
    end
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.destroy
    flash[:notice] = "Successfully removed #{@owner.proper_name} from the PATS system."
    redirect_to owners_url
  end
end
