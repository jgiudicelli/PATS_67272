class VaccinationsController < ApplicationController
  # GET /vaccinations
  # GET /vaccinations.json
  def index
    @vaccinations = Vaccination.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vaccinations }
    end
  end

  # GET /vaccinations/1
  # GET /vaccinations/1.json
  def show
    @vaccination = Vaccination.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vaccination }
    end
  end

  # GET /vaccinations/new
  # GET /vaccinations/new.json
  def new
    @vaccination = Vaccination.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vaccination }
    end
  end

  # GET /vaccinations/1/edit
  def edit
    @vaccination = Vaccination.find(params[:id])
  end

  # POST /vaccinations
  # POST /vaccinations.json
  def create
    @vaccination = Vaccination.new(params[:vaccination])

    respond_to do |format|
      if @vaccination.save
        format.html { redirect_to @vaccination, notice: 'Vaccination was successfully created.' }
        format.json { render json: @vaccination, status: :created, location: @vaccination }
      else
        format.html { render action: "new" }
        format.json { render json: @vaccination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vaccinations/1
  # PUT /vaccinations/1.json
  def update
    @vaccination = Vaccination.find(params[:id])

    respond_to do |format|
      if @vaccination.update_attributes(params[:vaccination])
        format.html { redirect_to @vaccination, notice: 'Vaccination was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vaccination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vaccinations/1
  # DELETE /vaccinations/1.json
  def destroy
    @vaccination = Vaccination.find(params[:id])
    @vaccination.destroy

    respond_to do |format|
      format.html { redirect_to vaccinations_url }
      format.json { head :no_content }
    end
  end
end
