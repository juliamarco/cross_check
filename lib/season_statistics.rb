module SeasonStatistics

  def game_by_type(type)
    games = []
    @games_data.each do |game|
      if game.type == type
        games << game.game_id
      end
    end
    games
  end

  def wins_percentage(type)
    games = game_by_type(type)
    hash = Hash.new(0)
    @games_teams_stats.each do |stat|
      if games.include?(stat.game_id)
        if hash.has_key?(stat.team_id)
          hash[stat.team_id].push(stat.won)
        else
          hash[stat.team_id] = [stat.won]
        end
      end
    end
    calculate_percentages(hash)
  end

  def calculate_percentages(hash)
    values = hash.values
    won_outcomes = values.map {|value| value.count("TRUE")}
    total_outcomes = values.map {|value| value.count}
    percentages = Hash.new
    hash.each do |key, value|
      percentages[key] = (won_outcomes[0].to_f / total_outcomes[0].to_f * 100).round(2)
      won_outcomes.shift
      total_outcomes.shift
    end
    return percentages
  end


  def biggest_bust
  end

  def biggest_surprise
  end

  def season_summary
  end

end
