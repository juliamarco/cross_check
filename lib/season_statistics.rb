module SeasonStatistics

  def game_by_type(season, type)
    games = games_by_season(season)
    games = @games_data.map do |game|
      if games.include?(game.game_id)
        if game.type == type
          game.game_id
        end
      end
    end.compact
  end

  def wins_percentage(season, type)
    games = game_by_type(season, type)
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


  def games_by_season(season)
    games = @games_data.find_all do |game|
      game.season == season
    end
    games.map do |game|
      game.game_id
    end
  end

  def biggest_bust(season)
    preseason = wins_percentage(season, "P")
    regular = wins_percentage(season, "R")
    arr = {}
    max = regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.max_by {|k,v| v}
    team_id_name(biggest[0])
  end

#helper method, maybe create a module for these?
  def team_id_name(id)
    team = @teams_data.find do |team|
      team.team_id == id
    end
    return team.teamName
  end


end
