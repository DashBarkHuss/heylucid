class RealityChecksController < ApplicationController
  before_action :set_reality_check, only: [:show, :edit, :update, :destroy]

  # GET /reality_checks
  # GET /reality_checks.json
  def index
    @reality_checks = RealityCheck.all
  end

  # GET /reality_checks/1
  # GET /reality_checks/1.json
  def show
  end

  # GET /reality_checks/new
  def new
    @reality_check = RealityCheck.new
  end

  # GET /reality_checks/1/edit
  def edit
  end

  # POST /reality_checks
  # POST /reality_checks.json
  def create
    @reality_check = RealityCheck.new(reality_check_params)

    respond_to do |format|
      if @reality_check.save
        format.html { redirect_to @reality_check, notice: 'Reality check was successfully created.' }
        format.json { render :show, status: :created, location: @reality_check }
      else
        format.html { render :new }
        format.json { render json: @reality_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reality_checks/1
  # PATCH/PUT /reality_checks/1.json
  def update
    respond_to do |format|
      if @reality_check.update(reality_check_params)
        format.html { redirect_to @reality_check, notice: 'Reality check was successfully updated.' }
        format.json { render :show, status: :ok, location: @reality_check }
      else
        format.html { render :edit }
        format.json { render json: @reality_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reality_checks/1
  # DELETE /reality_checks/1.json
  def destroy
    @reality_check.destroy
    respond_to do |format|
      format.html { redirect_to reality_checks_url, notice: 'Reality check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reality_check
      @reality_check = RealityCheck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reality_check_params
      params.fetch(:reality_check, {})
    end
end
