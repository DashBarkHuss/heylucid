class HomeController < ApplicationController
  def index
    # if user.admin?
    @reality_checks = RealityCheck.all

    
    # @number = 0
    # 
    def time_gap()
        @time_gaps = []
    end
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

    @time_since_last_check = Time.at((@today)-(@reality_checks.last.created_at))

  end

  def yesterdays_checks
    @yesterdays_reality_checks = RealityCheck.where(created_at: @yesterday..@start_of_day)
  end
end
