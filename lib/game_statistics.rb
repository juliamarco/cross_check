module GameStatistics

  def highest_total_score #tested line 53
   highest = @games_data.max_by do |game|
     game.away_goals + game.home_goals
   end
   return highest.home_goals + highest.away_goals
 end

 def lowest_total_score #tested line 58
   lowest = @games_data.min_by do |game|
     game.away_goals + game.home_goals
   end
   return lowest.home_goals + lowest.away_goals
 end

 def biggest_blowout #tested line 63
   all_nums = @games_data.map do |game|
     game.away_goals - game.home_goals
   end
   num = all_nums.max_by do |num|
     num.abs
   end
   return num.abs
 end

 def counts_venues_occurrences #tested line 68
   counts = Hash.new(0)
   @games_data.each do |game|
     counts[game.venue] += 1
   end
   return counts
 end

 def most_popular_venue #tested line 74
   counts = counts_venues_occurrences
   max = counts.max_by do |key, value|
    value
   end
   return max[0]
 end

 def least_popular_venue #tested line 79
   counts = counts_venues_occurrences
   min = counts.min_by do |key, value|
       value
   end
   return min[0]
 end

 def percentage_home_wins #tested line 84
   outcomes = @games_data.map do |game|
      game.outcome
   end
   home_wins = outcomes.count do |outcome|
     outcome.include?("home")
   end
   (home_wins.to_f / outcomes.length.to_f * 100.0).round(2)
 end

 def percentage_visitor_wins #tested line 89
   outcomes = @games_data.map do |game|
      game.outcome
   end
   home_wins = outcomes.count do |outcome|
     outcome.include?("away")
   end
   (home_wins.to_f / outcomes.length.to_f * 100.0).round(2)
 end

 def season_with_most_games #tested line 90
   counts = count_of_games_by_season
   max = counts.max_by do |key, value|
     value
   end
   return max[0]
 end

 def season_with_fewest_games #tested line 99
   counts = count_of_games_by_season
   min = counts.min_by do |key, value|
     value
   end
   return min[0]
 end

 def count_of_games_by_season #tested line 104
   counts = Hash.new(0)
   @games_data.each do |game|
     counts[game.season] += 1
   end
   return counts
 end

 def average_goals_per_game #tested line 110
   total_scores = @games_data.map do |game|
     game.away_goals.to_f + game.home_goals.to_f
   end
   (total_scores.sum / total_scores.count).round(1)
 end

 def average_goals_by_season #tested line 115
      average = Hash.new(0)
      @games_data.each do |game|
        average_goals = (game.home_goals.to_f + game.away_goals.to_f) / 2.0
        if average.has_key?(game.season)
          average[game.season].push(average_goals)
        else
          average[game.season] = [average_goals]
        end
      end
      all_values = average.map do |key, value|
        value = value.sum / value.count
        value.round(1)
      end
      average.map do |key, value|
        value = all_values[0]
        average[key] = value
        all_values.shift
      end
      return average
    end

end
