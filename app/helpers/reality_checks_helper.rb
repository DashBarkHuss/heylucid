module RealityChecksHelper
  def yesterdays_checks_count
    # @user.authenticate
    @yesterday_checks = RealityCheck.where(created_at: @yesterday..@start_of_day, user_id: @user.id)
    @yesterday_checks ? @yesterday_checks.count : 0
  end
end
