module TimeHelper
  HOURS_OFFSET = 4

  def call_time
    return format_time('seconds') if less_than_1_min?
    return format_time('minutes') if less_than_1_hr?
    return format_time('hours') if less_than_1_day?
    format_time('days')
  end

  def less_than_1_min?
    seconds_since_last_check(@user) < 60
  end

  def less_than_1_hr?
    return true if less_than_1_min?
    seconds_since_last_check(@user) < 3600
  end

  def less_than_1_day?
    return true if less_than_1_hr?
    seconds_since_last_check(@user) < 86400
  end

  def format_time(time_increment)
    # This should be a case statement but wanted to keep it simple
    if time_increment == 'seconds'
      seconds = seconds_since_last_check(@user).floor
      return seconds.to_s + " Seconds"
    elsif time_increment == 'minutes'
      mins = (seconds_since_last_check(@user) / 60).floor
      return mins.to_s + " Minutes"
    elsif time_increment == 'hours'
      hours = (seconds_since_last_check(@user) / 3600).floor
      return hours.to_s + " Hours"
    else
      days = (seconds_since_last_check(@user) / 86400).floor
      return "#{days} Days"
    end
  end

  def seconds_since_last_check(user)
    last_check_time = user.reality_checks.last.created_at.localtime.to_datetime
    now = DateTime.current
    diff = TimeDifference.between(last_check_time, DateTime.current).in_seconds
  end

  def yesterday?
    start_of_yesterday = DateTime.current.yesterday.beginning_of_day + HOURS_OFFSET
    end_of_yesterday = DateTime.current.beginning_of_day + HOURS_OFFSET
    DateTime.current.between?(start_of_yesterday, end_of_yesterday)
  end
end
