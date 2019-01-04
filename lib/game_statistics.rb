module GameStatistics

  def highest_total_score #tested line 53
   highest = @games_data.max_by { |game| game.away_goals + game.home_goals }
   return highest.home_goals + highest.away_goals
  end

  def lowest_total_score #tested line 58
   lowest = @games_data.min_by { |game| game.away_goals + game.home_goals }
   return lowest.home_goals + lowest.away_goals
  end

  def biggest_blowout #tested line 63
   difference_in_goals = @games_data.map { |game| game.away_goals - game.home_goals }
   difference_in_goals.max_by { |difference| difference.abs }.abs
  end

  def counts_venues_occurrences #tested line 68
   occurences = Hash.new(0)
   @games_data.each { |game| occurences[game.venue] += 1 }
   return occurences
  end

  def most_popular_venue #tested line 74
   max = counts_venues_occurrences.max_by { |venue, occurence| occurence }
   return max[0]
  end

  def least_popular_venue #tested line 79
   min = counts_venues_occurrences.min_by { |venue, occurence| occurence }
   return min[0]
  end

  def percentage_home_wins #tested line 84
   outcomes = @games_data.map { |game| game.outcome }
   home_wins = outcomes.count { |outcome| outcome.include?("home") }
   (home_wins.to_f / outcomes.length.to_f).round(2)
  end

  def percentage_visitor_wins #tested line 89
   outcomes = @games_data.map { |game| game.outcome }
   home_wins = outcomes.count { |outcome| outcome.include?("away") }
   (home_wins.to_f / outcomes.length.to_f).round(2)
  end

  def season_with_most_games #tested line 90
    count_of_games_by_season.max_by { |season, game_count| game_count }[0].to_i
  end

  def season_with_fewest_games #tested line 99
    min = count_of_games_by_season.min_by { |season, game_count| game_count }[0].to_i
  end

  def count_of_games_by_season #tested line 104
   counts = Hash.new(0)
   @games_data.each do |game|
     counts[game.season.to_s] += 1
   end
   return counts
  end

  def average_goals_per_game #tested line 110
   total_scores = @games_data.map do |game|
     game.away_goals.to_f + game.home_goals.to_f
   end
   (total_scores.sum / total_scores.count).round(2)
  end

  def average_goals_by_season
    average = Hash.new(0)
    @games_data.each do |game|
      total_goals = (game.home_goals.to_f + game.away_goals.to_f)
      if average.has_key?(game.season.to_s)
        average[game.season.to_s].push(total_goals)
      else
        average[game.season.to_s] = [total_goals]
      end
    end
    averaged_goals = average.map do |season, goals|
      goals = goals.sum / goals.count
      goals.round(2)
    end
    average.map do |season, averages|
      averages = averaged_goals[0]
      average[season] = averages
      averaged_goals.shift
    end
    return average
  end


end
