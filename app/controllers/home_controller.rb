class HomeController < ApplicationController
  def index
    @number = 0
    @reality_checks = RealityCheck.all
    @time_gaps = []
    @timezone = 'Eastern Time (US & Canada)'
    @today = Time.zone.now.in_time_zone(@time_zone)

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
    @yesterdays_reality_checks = RealityCheck.where(created_at: @yesterday..@start_of_day)

  end
end
