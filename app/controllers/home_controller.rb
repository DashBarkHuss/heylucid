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

    @reality_checks_score = []
    @reality_checks_today.each do |rc|
    @reality_checks_score.push(rc.created_at)
    end
    @reality_checks_score.push(@today)

    #time gaps
    @iter = 0
    @reality_checks_score.each do |reality_check|
      @iter += 1

      unless @iter == @reality_checks_score.count
        i=(@reality_checks_score[@iter]) - (@reality_checks_score[@iter-1])

        @time_gaps.push(i)
      end
    end



    #the code below is all just to get a score for the gauge

    #time1 = 300 # change to 600 for 10 minutes

    def calculate_score(time1, rc_day, rc_times)

      @iterator = 0
      @misses = 0


      if rc_day.empty? == false



          rc_times.each do |rc|
              puts
              puts @iterator.to_s + "." # 1.
              if @iterator == 0
                  puts "first rc"

              elsif (rc-@last_rc) > time1
                lose = ((rc-@last_rc)/time1.to_f).floor
                @misses += lose
                puts "missed " + lose.to_s + " times. total misses = " + @misses.to_s

              elsif rc-@last_rc <= time1
                  puts "RC"
              end
          @iterator+=1
          @last_rc = rc
          puts @last_rc
          end

      elsif  rc_day.empty? == true
          puts "you didn't reality check"
          score = 0
      end
      puts
          puts @misses

          total_segments = unless ((@reality_checks_score.last - @reality_checks_score.first)/time1.to_f).ceil == 0
            ((@reality_checks_score.last - @reality_checks_score.first)/time1.to_f).ceil

          else

            1
          end

          puts total_segments

          @hits = total_segments - @misses
          puts @hits.to_s + " hits out of " + total_segments.to_s + " segments"
    puts "next segment starts in " + Time.at(time1 - ((@today-@reality_checks_today.last.created_at)%time1)).utc.strftime("%H:%M:%S").to_s
    score = ((@hits/total_segments.to_f) * 100).round
          puts score
          score
    end #end calculate_score
    time1 = 300 #5
    time2 = 900 #15
    time3 = 1800 #30
    @next_segment_start = Time.at(time1 - (((@today) - (@reality_checks_today.first.created_at))%time1))

    # @score_1 = calculate_score time1
    # @score_2 = calculate_score time2
    # @score_3 = calculate_score time3

    @level_text = "Level: 1"

    @yesterdays_reality_checks_times = []
    @yesterdays_reality_checks.each do |rc|
    @yesterdays_reality_checks_times.push(rc.created_at)
    end

    # yesterday_score = calculate_score

    @level_1_score = calculate_score 3600, @reality_checks_today, @reality_checks_score #1 hour
    @level_2_score = calculate_score 2700, @reality_checks_today, @reality_checks_score #45 min
    @level = @level_1_score
    puts "score1 " + @score_1.to_s
    puts "score2 " + @score_2.to_s
    puts "score3 " + @score_3.to_s
    puts @today
    puts @reality_checks_today.first.created_at
    puts @reality_checks_today.first.created_at



    def gauge
      @gauge_set = 97

    end

  end
end
