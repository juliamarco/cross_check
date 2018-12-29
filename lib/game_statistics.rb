module GameStatistics

  def highest_total_score
   highest = @games_data.max_by do |game|
     game.away_goals + game.home_goals
   end
   return highest.home_goals + highest.away_goals
 end

 def lowest_total_score
   lowest = @games_data.min_by do |game|
     game.away_goals + game.home_goals
   end
   return lowest.home_goals + lowest.away_goals
 end

 def biggest_blowout
   all_nums = @games_data.map do |game|
     game.away_goals - game.home_goals
   end
   num = all_nums.max_by do |num|
     num.abs
   end
   return num.abs
 end

 def counts_venues_occurrences
   counts = Hash.new(0)
   @games_data.each do |game|
     counts[game.venue] += 1
   end
   return counts
 end

 def most_popular_venue
   counts = counts_venues_occurrences
   max = counts.max_by do |key, value|
    value
   end
   return max[0]
 end

 def least_popular_venue
   counts = counts_venues_occurrences
   min = counts.min_by do |key, value|
       value
   end
   return min[0]
 end

 def percentage_home_wins
   outcomes = @games_data.map do |game|
      game.outcome
   end
   home_wins = outcomes.count do |outcome|
     outcome.include?("home")
   end
   home_wins.to_f / outcomes.length.to_f * 100.0
 end

 def percentage_visitor_wins
   outcomes = @games_data.map do |game|
      game.outcome
   end
   home_wins = outcomes.count do |outcome|
     outcome.include?("away")
   end
   home_wins.to_f / outcomes.length.to_f * 100.0
 end

 def count_of_games_by_season
   counts = Hash.new(0)
   @games_data.each do |game|
     counts[game.season] += 1
   end
   return counts
 end

 def season_with_most_games
   counts = count_of_games_by_season
   max = counts.max_by do |key, value|
     value
   end
   return max[0].to_s
 end

 def season_with_fewest_games
   counts = count_of_games_by_season
   min = counts.min_by do |key, value|
     value
   end
   return min[0].to_s
 end

 def average_goals_per_game
   total_scores = @games_data.map do |game|
     game.away_goals.to_f + game.home_goals.to_f
   end
   (total_scores.sum / total_scores.count)
 end

 def average_goals_by_season
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
