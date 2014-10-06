class CodeNamesController < ApplicationController
  before_action :set_code_name, only: [:show, :edit, :update, :destroy]

  # GET /code_names
  # GET /code_names.json
  def index
    @code_names = CodeName.all
  end

  # GET /code_names/1
  # GET /code_names/1.json
  def show
  end

  # GET /code_names/new
  def new
    @code_name = CodeName.new
  end

  # GET /code_names/1/edit
  def edit
  end

  # POST /code_names
  # POST /code_names.json
  def create
    @code_name = CodeName.new(code_name_params)

    respond_to do |format|
      if @code_name.save
        format.html { redirect_to code_names_path, notice: 'Code name was successfully created.' }
        format.json { render :show, status: :created, location: @code_name }
      else
        format.html { render :new }
        format.json { render json: @code_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /code_names/1
  # PATCH/PUT /code_names/1.json
  def update
    respond_to do |format|
      if @code_name.update(code_name_params)
        format.html { redirect_to @code_name, notice: 'Code name was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_name }
      else
        format.html { render :edit }
        format.json { render json: @code_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /code_names/1
  # DELETE /code_names/1.json
  def destroy
    @code_name.destroy
    respond_to do |format|
      format.html { redirect_to code_names_url, notice: 'Code name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_name
      @code_name = CodeName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_name_params
      params.require(:code_name).permit(:name, :info_reference, :damage)
    end
end
