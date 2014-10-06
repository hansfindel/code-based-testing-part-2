class TimeTravellersController < ApplicationController
  before_action :set_time_traveller, only: [:show, :edit, :update, :destroy]

  # GET /time_travellers
  # GET /time_travellers.json
  def index
    @time_travellers = TimeTraveller.all
  end

  # GET /time_travellers/1
  # GET /time_travellers/1.json
  def show
  end

  # GET /time_travellers/new
  def new
    @time_traveller = TimeTraveller.new
  end

  # GET /time_travellers/1/edit
  def edit
  end

  # POST /time_travellers
  # POST /time_travellers.json
  def create
    @time_traveller = TimeTraveller.new(time_traveller_params)

    respond_to do |format|
      if @time_traveller.save
        format.html { redirect_to @time_traveller, notice: 'Time traveller was successfully created.' }
        format.json { render :show, status: :created, location: @time_traveller }
      else
        format.html { render :new }
        format.json { render json: @time_traveller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_travellers/1
  # PATCH/PUT /time_travellers/1.json
  def update
    respond_to do |format|
      if @time_traveller.update(time_traveller_params)
        format.html { redirect_to @time_traveller, notice: 'Time traveller was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_traveller }
      else
        format.html { render :edit }
        format.json { render json: @time_traveller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_travellers/1
  # DELETE /time_travellers/1.json
  def destroy
    @time_traveller.destroy
    respond_to do |format|
      format.html { redirect_to time_travellers_url, notice: 'Time traveller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_traveller
      @time_traveller = TimeTraveller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_traveller_params
      params.require(:time_traveller).permit(:name, :damage)
    end
end
