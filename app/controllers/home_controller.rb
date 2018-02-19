class HomeController < ApplicationController
  def index
    @number = 0
    @reality_checks = RealityCheck.all
    @reality_checks_today = RealityCheck.where("created_at >= ?", DateTime.now.in_time_zone('Eastern Time (US & Canada)').beginning_of_day)
  end
end
