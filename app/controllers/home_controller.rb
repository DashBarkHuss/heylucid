class HomeController < ApplicationController
  def yesterdays_checks
    @yesterdays_reality_checks = RealityCheck.where(created_at: @yesterday..@start_of_day)
  end

  def landing_page
    @user = fake_user
    render 'users/show'
  end
end
