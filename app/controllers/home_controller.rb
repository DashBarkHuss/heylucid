class HomeController < ApplicationController
  def index
    @start_time = Time.zone.parse('2018-02-19 11:08:32')
    @number = 0
    @reality_checks = RealityCheck.all
    @time_gaps = []

    #gets reality checks after 4am on today
    if DateTime.now.in_time_zone('Eastern Time (US & Canada)').strftime("%H").to_i >= 4
    @reality_checks_today = RealityCheck.where("created_at >= ?", DateTime.now.in_time_zone('Eastern Time (US & Canada)').beginning_of_day + 4.hours)
  else
    @reality_checks_today = RealityCheck.where("created_at >= ?", DateTime.now.in_time_zone('Eastern Time (US & Canada)').beginning_of_day - 1.day + 4.hours)
  end
end
end
