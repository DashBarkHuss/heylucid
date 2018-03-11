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

    #time1 = 300 # change to 600 for 10 minutes
    time2 = 1200 #20
    time3 = 2400 #40
    time4 = 3600 #60
    time5 = 5400 #90

    def calculate_score(time1)
    @time_since_start = (@today) - (@reality_checks_today.first.created_at) #today means now, change to now later
    @iterator = 0
    @time_segment_start = 0
    @time_segment_end = 0
    @time_passed_at_check = 0
    @hits = 0
    @misses = 0
    #reality_checks_today = ["boob"]



    if @reality_checks_today.empty? == false
      loop do
        puts
        puts @iterator.to_s + "." # 1.

        @time_segment_end = @time_segment_start + time1

        puts "segment: " + @time_segment_start.to_s + " - " + @time_segment_end.to_s  # segment: 7000 - 8000

        @index = 0 #create and reset index to 0

        unless @iterator == 0
          @time_gaps.each do |time|

            @time_passed_at_check += time
            #@index1 = @index
            if @time_passed_at_check >= @time_segment_end
              @misses += 1
              puts "miss"
              break
            end

            if @time_passed_at_check >= @time_segment_start && @time_passed_at_check < @time_segment_end
              @hits += 1
              puts "hit"
              break #if a point was already added in this segment, ignore other rc's and don't change index
            end

            if @index == @time_gaps.count - 1 #if we got to the end and no index
              unless @iterator == 0
                @misses += 1
                puts "miss"
              end
              break #or else 1 will be added to index, giving us the wrong index
            end


            @index += 1

          end
        end

        @time_segment_start += time1


        if @iterator == 0 && @reality_checks_today.empty? == false
          @hits += 1
          puts "hit"
        end


        puts "hits: " + @hits.to_s
        @iterator += 1
        puts "time passed: " +  @time_passed_at_check.to_s
        @time_passed_at_check = 0


        if @time_segment_end >= @time_since_start || @index == (@time_gaps.count - 1) #@index1 == (@time_gaps.count - 1)
          puts
          puts "@time_segment_end >= @time_since_start: " + (@time_segment_end == @time_since_start).to_s
          #puts "@index1 == @time_gaps.count - 1: " + (@index1 == @time_gaps.count - 1).to_s
          puts "@index == @time_gaps.count - 1: " + (@index == @time_gaps.count - 1).to_s

          puts "segment: " + @time_segment_start.to_s + " Since start: " + @time_since_start.to_s + " index: " + @index1.to_s + " total time gaps - 1: " + (@time_gaps.count-1).to_s

          #puts  puts "ind: " + @index.to_s + " ind1: " + @index1.to_s
          puts  puts "ind: " + @index.to_s

          break
        end
      end

    elsif @reality_checks_today.empty? == true
      @hits = 0
      puts "you didn't reality check"
    end


    puts @hits
    puts @misses

    total_segments = (@time_since_start/time1.to_f).round
    puts @hits.to_s + " hits out of " + total_segments.to_s + " segments"
    puts "next segment starts in " + Time.at(time1 - (@time_since_start%time1)).utc.strftime("%H:%M:%S").to_s
    score = (@hits/total_segments.to_f) * 100
    puts score
    puts "time till 10 pm" + Time.at((@today.beginning_of_day + 22.hours) - @today).utc.strftime("%H:%M:%S").to_s

    score
    #end of code for score
    end #end calculate_score

    @next_segment_start = Time.at(300 - (((@today) - (@reality_checks_today.first.created_at))%300))

    @score_1 = calculate_score 300 #5
    @score_2 = calculate_score 900 #15
    @score_3 = calculate_score 1800
    puts "score1 " + @score_1.to_s
    puts "score2 " + @score_2.to_s
    puts "score3 " + @score_3.to_s



    def gauge
      @gauge_set = 97

    end

  end
end
