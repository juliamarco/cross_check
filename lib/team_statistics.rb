module TeamStatistics

  def team_info(team_id)
    team = @teams_data.find do |team|
      team.team_id == team_id
    end
    new = Hash.new(0)
    new["team_id"] = team.team_id
    new["franchiseId"] = team.franchiseId
    new["shortName"] = team.shortName
    new["teamName"] = team.teamName
    new["abbreviation"] = team.abbreviation
    new["link"] = team.link
    return new
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

  def games_won_by_season(team_id)
    hash = @games_data.group_by do |game|
      game.season
    end
    new_hash = Hash.new(0)
      hash.each do |k,v|
        all = v.find_all {|game| game.home_team_id == team_id || game.away_team_id == team_id}
        new_hash[k] = all.map{|game|game.game_id}
      end
      new_hash = new_hash.reject {|k,v| v.empty?}
      new_hash.each do |k,v|
        @games_teams_stats.map do |stat|
          if v.include?(stat.game_id)
            if stat.team_id == team_id
              new_hash[k] << stat.won
            end
          end
        end
      end
      new_hash.each do |key,values|
        values = values.select do |v|
          v.is_a?(String)
        end
        new_hash[key] = values
      end
  end

  def best_season(team_id)
    games = games_won_by_season(team_id)
    calculate_percentages(games).max_by {|k,v| v}[0]
  end

  def worst_season(team_id)
    games = games_won_by_season(team_id)
    calculate_percentages(games).min_by {|k,v| v}[0]
  end

  def average_win_percentage(team_id)
    games = games_won_by_season(team_id)
    percentages = calculate_percentages(games)
    (percentages.sum {|k,v| v}) / percentages.count
  end

  def all_team_goals(team_id)
    @games_teams_stats.map do |stat|
      if stat.team_id == team_id
        stat.goals
      end
    end.compact
  end

  def most_goals_scored(team_id)
    all_team_goals(team_id).max
  end

  def fewest_goals_scored(team_id)
    all_team_goals(team_id).min
  end

  def collect_home_games(team_id, hash)
    @games_data.each do |game|
      if game.home_team_id == team_id
        if hash.has_key?(game.away_team_id)
          hash[game.away_team_id] << game.game_id
        else
          hash[game.away_team_id] = [game.game_id]
        end
      end
    end
  end

  def collect_away_games(team_id, hash)
    @games_data.each do |game|
      if game.away_team_id == team_id
        if hash.has_key?(game.home_team_id)
          hash[game.home_team_id] << game.game_id
        else
          hash[game.home_team_id] = [game.game_id]
        end
      end
    end
  end

  def team_id_name(id)
    team = @teams_data.find do |team|
      team.team_id == id
    end
    return team.teamName
  end

  def favorite_opponent(team_id)
    hash = Hash.new
    collect_home_games(team_id, hash)
    collect_away_games(team_id, hash)
    hash.each do |k,v|
      values = @games_teams_stats.map do |stat|
        if k == stat.team_id && v.include?(stat.game_id)
          stat.won
        end
      end.compact
    hash[k] = values
    end
    team = calculate_percentages(hash).min_by{|k,v| v}[0]
    team_id_name(team)
  end



end
