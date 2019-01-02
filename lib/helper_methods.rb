module HelperMethods

  def team_id_name(id) #tested line 132
    team = @teams_data.find { |team| team.team_id == id }
    return team.teamName
  end

  def calculate_percentages(hash) #tested line 190/195
    values = hash.values
    won_outcomes = values.map {|value| value.count("TRUE")}
    total_outcomes = values.map {|value| value.count}
    percentages = Hash.new
    hash.each do |key, value|
      percentages[key] = (won_outcomes[0].to_f / total_outcomes[0].to_f * 100).round(1)
      won_outcomes.shift
      total_outcomes.shift
    end
    return percentages
  end

  def wins_percentage(season, type) #tested line 247
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

  def away_goals_allowed(games, team_id) #tested line 269
    away_goals_allowed = 0
    @games_data.each do |game|
      if games.include?(game.game_id)
        if game.away_team_id == team_id
          away_goals_allowed += game.home_goals
        end
      end
    end
    return away_goals_allowed
  end

  def home_goals_scored(games, team_id) #tested line 275
    home_goals_scored = 0
    @games_data.each do |game|
      if games.include?(game.game_id)
        if game.home_team_id == team_id
          home_goals_scored += game.home_goals
        end
      end
    end
    return home_goals_scored
  end

end
