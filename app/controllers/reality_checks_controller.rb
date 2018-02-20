class RealityChecksController < ApplicationController
  before_action :set_reality_check, only: [:show, :edit, :update, :destroy]

  # GET /reality_checks
  # GET /reality_checks.json
  def index
    @number = 0
    @reality_checks = RealityCheck.all
    @time_gaps = []
    @today = Time.zone.now

    #sets start_of_day differently if its BEFORE or AFTER 4am______ eventually have start time specified by user. This is for if the user is a night owl, their reality checks after 12 am will count as the same day
    @start_time = 4 #4am
    if @today.strftime("%H").to_i >= @start_time
    @same_day = true
    @start_of_day = @today.beginning_of_day + @start_time.hours
    else
    @same_day = false
    @start_of_day = @today.beginning_of_day - 1.day + @start_time.hours
    end

    @yesterday = @start_of_day - 1.day
    @reality_checks_today = RealityCheck.where("created_at >= ?", @start_of_day)
    @yesterdays_reality_checks = RealityCheck.where(created_at: @yesterday..@start_of_day)  end



    @reality_check_id= []

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
