module TeamStatisticsHM

  def team_id_name(id)
    team = @teams_data.find { |team| team.team_id == id }
    return team.team_name
  end

  def games_played_by_season(team_id)
    games_by_season = @games_data.group_by { |game| game.season }
      games_by_season.each do |season,games|
        all_games_played = games.find_all do |game|
          game.home_team_id == team_id || game.away_team_id == team_id
        end
        games_by_season[season] = all_games_played.map { |game| game.game_id }
      end
    return games_by_season
  end

  def games_won_by_season(team_id)
    team_id = team_id.to_i
    games_by_season = games_played_by_season(team_id)
      games_by_season = games_by_season.reject { |season, games| games.empty? }
      games_by_season.each do |season, games|
        @games_teams_stats.map do |stat|
          if games.include?(stat.game_id)
            if stat.team_id == team_id
              games_by_season[season].push(stat.won)
            end
          end
        end
      end
      games_by_season.each do |season, games|
        game_results = games.reject { |game| game.is_a?(Numeric) }
        games_by_season[season] = game_results
      end
  end

  def all_team_goals(team_id)
    @games_teams_stats.map do |stat|
      if stat.team_id == team_id
        stat.goals
      end
    end.compact
  end

# This method starts with an empty hash, and builds it.
  def collect_home_games_opponents(team_id, hash)
    @games_data.each do |game|
      if game.home_team_id == team_id
        if hash.has_key?(game.away_team_id)
          hash[game.away_team_id].push(game.game_id)
        else
          hash[game.away_team_id] = [game.game_id]
        end
      end
    end
    return hash
  end

  # This method starts with an empty hash, and builds it.
  def collect_away_games_opponents(team_id, hash)
    @games_data.each do |game|
      if game.away_team_id == team_id
        if hash.has_key?(game.home_team_id)
          hash[game.home_team_id].push(game.game_id)
        else
          hash[game.home_team_id] = [game.game_id]
        end
      end
    end
    return hash
  end

  def get_opponents_results(team_id, hash)
    collect_home_games_opponents(team_id, hash)
    collect_away_games_opponents(team_id, hash)
    games_collection = hash
    games_collection.each do |team_id, game_id|
      results = @games_teams_stats.map do |stat|
        if team_id == stat.team_id && game_id.include?(stat.game_id)
          stat.won
        end
      end.compact
    games_collection[team_id] = results
    end
  end

  def get_goals_blowout(games)
    @games_data.map do |game|
      if games.include?(game.game_id)
        (game.away_goals - game.home_goals).abs
      end
    end.compact
  end

  def all_opponents(id)
    @games_data.map do |game|
      if game.away_team_id == id
        game.home_team_id
      elsif game.home_team_id == id
        game.away_team_id
      end
    end.compact.uniq
  end

  def games_played_against(team_id, opponent)
    @games_data.count do |game|
      game.away_team_id == team_id && game.home_team_id == opponent ||
       game.home_team_id == team_id && game.away_team_id == opponent
    end
  end

  def games_won_against(team_id, opponent)
    @games_data.count do |game|
      game.away_team_id == team_id && game.home_team_id == opponent && game.outcome.include?("away") ||
       game.home_team_id == team_id && game.away_team_id == opponent && game.outcome.include?("home")
    end
  end

end
