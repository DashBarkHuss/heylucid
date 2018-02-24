class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  # 
  # 
  # 
  
def index
    # if user.admin?
    @reality_checks = RealityCheck.all
end

        
    # else
    #     @reality_checks = RealityCheck.where(user_id: current_user.id)
        
    # end
    # 
    def current_day
      @today = Time.zone.now
    end
    
    @number = 0
    
    @time_gaps = []
    def start_day
      @start_of_day = Time
      Date.to_time.in_time_zone('America/New_York').beginning_of_day
    end

    def user_time_zone(time_zone)
    end
    #sets start_of_day differently if its BEFORE or AFTER 4am______ eventually have start time specified by user. This is for if the user is a night owl, their reality checks after 12 am will count as the same day
    @start_time = 4 #4am
  def same_day?
    if @today.strftime("%H").to_i >= @start_time
    @same_day = true
    @start_of_day = @today.beginning_of_day + @start_time.hours
    else
    @same_day = false
    @start_of_day = @today.beginning_of_day - 1.day + @start_time.hours
    end

    @yesterday = @start_of_day - 1.day
    @reality_checks_today = RealityCheck.where("created_at >= ?", @start_of_day)

    @time_since_last_check = Time.at((@today)-(@reality_checks.last.created_at))

  end

  def yesterdays_checks
    @yesterdays_reality_checks = RealityCheck.where(created_at: @yesterday..@start_of_day)
  end




  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # byebug
    if @user == session[:user_id]
      flash[:notice]  = 'Logged In successfully'
      render 'show'
    else
      redirect_to root_path
      flash[:error] = "Access Denied"
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
