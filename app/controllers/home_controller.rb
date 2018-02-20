class HomeController < ApplicationController
  def index
    @start_time = Time.zone.parse('2018-02-19 11:08:32')
    @number = 0
    @reality_checks = RealityCheck.all
    @time_gaps = []

    #gets reality checks after 4am on today
    @reality_checks_today = RealityCheck.where("created_at >= ?", DateTime.now.in_time_zone('Eastern Time (US & Canada)').beginning_of_day + 4.hours)
  end
end
