class HomeController < ApplicationController
  def index
    @number = 0
    @reality_checks = RealityCheck.all

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
    @yesterdays_reality_checks = RealityCheck.where(created_at: @yesterday..@start_of_day)

    @time_since_last_check = Time.at((@today)-(@reality_checks.last.created_at))

    @time_gaps = []
    #@time_gaps = [150, 150, 150, 150, 150, 150, 150, 150] # 2.5 minutes

    #time gaps
    @iter = 0
    @reality_checks_today.each do |reality_check|
        @iter += 1

    unless @iter == @reality_checks_today.count
      i=(@reality_checks_today[@iter].created_at - @reality_checks_today[@iter-1].created_at)

      @time_gaps.push(i)
      end
    end



    #the code below is all just to get a score for the gauge
    @gauge_set = 0
    @iterator = 0

    @time_passed =0
    time1 = 600 #10
    time2 = 1200 #20
    time3 = 2400 #40
    time4 = 3600 #60
    time5 = 5400 #90


    @time_gaps.each do |time|
        puts
        puts @iterator.to_s + "."
        puts "time passed: " + @time_passed.to_s
        puts time

        case
        when time<time1 && @time_passed == 0 # less than 600 and no time passed-- ADD
          puts "5+ to gauge"
          @gauge_set += 5
         @time_passed = time
         puts "time passed: " + @time_passed.to_s


        when time<time1 && @time_passed != 0 && @time_passed < time1 && (@time_passed + time) >= time1 # less than 600 and 1-599 time passed-
          puts "5+ to gauge"
          @gauge_set += 5
          @time_passed += time
          @time_passed -= time1
          puts "time passed: " + @time_passed.to_s

         when time<time1 && @time_passed != 0 && @time_passed < time1 && (@time_passed + time) < time1 # less than 600 and 1-599 time passed-
          @time_passed += time
          puts "time passed: " + @time_passed.to_s




         when (time1...time2) === time #10-20 min
             puts "3+ to gauge"
             @gauge_set += 3

        when (time2...time3) === time #20 - 40 min
                puts "2+ to gauge"
             @gauge_set += 2

        when (time3...time4) === time #40 - 60 min
            puts "1+ to gauge"
            @gauge_set += 1

        when (time4...time5) === time #60 - 90 min
            puts "-5 to gauge"
            @gauge_set -= 5

        when time >= time5 #90min
            puts "-10 to gauge"
            @gauge_set -= 10

        else
          puts "You gave me #{time} -- I have no idea what to do with that."

        end

        puts "gauge: " + @gauge_set.to_s
        @iterator += 1
    end

    #end of code for score




  def gauge
    @gauge_set = 97

    end

  end
end
