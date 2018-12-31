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

  def get_opponents_results(team_id, hash)
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
  end

  def favorite_opponent(team_id)
    hash = Hash.new
    get_opponents_results(team_id, hash)
    team = calculate_percentages(hash).min_by{|k,v| v}[0]
    team_id_name(team)
  end

  def rival(team_id)
    hash = Hash.new
    get_opponents_results(team_id, hash)
    team = calculate_percentages(hash).max_by{|k,v| v}[0]
    team_id_name(team)
  end

  def get_goals_blowout(games)
    @games_data.map do |game|
      if games.include?(game.game_id)
        (game.away_goals - game.home_goals).abs
      end
    end.compact
  end

  def biggest_team_blowout(team_id)
    games_won = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "TRUE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_won).max
  end

  def worst_loss(team_id)
    games_lost = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "FALSE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_lost).max
  end

  def head_to_head(team_id, opponent_id)
    games_played = @games_data.map do |game|
      if game.away_team_id == team_id && game.home_team_id == opponent_id ||game.home_team_id == team_id && game.away_team_id == opponent_id
        game.game_id
      end
    end.compact
    hash = {win: 0, loss: 0}
    @games_teams_stats.each do |stat|
      if games_played.include?(stat.game_id) && stat.team_id == team_id
        if stat.won == "TRUE"
          hash[:win] += 1
        else
          hash[:loss] += 1
        end
      end
    end
    hash
  end

#method copied from season statistic
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

  #method copied from season statistic
  def away_goals_allowed(games, team_id)
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

  #method copied from season statistic
  def home_goals_scored(games, team_id)
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


  def seasonal_summary(team_id)
    seasons_played = @games_data.map do |game|
      if game.away_team_id == team_id || game.home_team_id == team_id
        game.season
      end
    end.compact.uniq
    hash = Hash.new
    seasons_played.each do |season|
      hash[season] = {:preseason => {:win_percentage => 0, :total_goals_scored => 0, :total_goals_against => 0, :average_goals_scored => 0, :average_goals_against => 0}, :regular_season => {:win_percentage => 0, :total_goals_scored => 0, :total_goals_against => 0, :average_goals_scored => 0, :average_goals_against => 0}}
    end
    seasons_played.each do |season|
      percent_preseason = wins_percentage(season,"P").find {|k,v| k == team_id}[1]
      percent_regseason = wins_percentage(season,"R").find {|k,v| k == team_id}[1]
      hash[season][:preseason][:win_percentage] = percent_preseason
      hash[season][:regular_season][:win_percentage] = percent_regseason
    end
    preseason_games = games_by_team_type_and_season(team_id, "P", seasons_played)
    regseason_games = games_by_team_type_and_season(team_id, "R", seasons_played)
    preseason_games.each do |k, v|
      @games_teams_stats.each do |game|
        # binding.pry
        if v.include?(game.game_id) && game.team_id == team_id
          hash[k][:preseason][:total_goals_scored] += game.goals
        elsif v.include?(game.game_id) && game.team_id != team_id
          hash[k][:preseason][:total_goals_against] += game.goals
        end
      end
    end


    regseason_games.each do |k, v|
      @games_teams_stats.each do |game|
        if v.include?(game.game_id)&& game.team_id == team_id
          hash[k][:regular_season][:total_goals_scored] += game.goals
        elsif v.include?(game.game_id) && game.team_id != team_id
          hash[k][:regular_season][:total_goals_against] += game.goals
        end
      end
    end
    preseason_games.each do |k,v|
      total = v.count
      goals_scored = hash[k][:preseason][:total_goals_scored]
      unless goals_scored.zero?
        hash[k][:preseason][:average_goals_scored] = (goals_scored.to_f / total.to_f).round(2)
      end
      goals_against = hash[k][:preseason][:total_goals_against]
      unless goals_against.zero?
        hash[k][:preseason][:average_goals_against] = (goals_against.to_f / total.to_f).round(2)
      end
    end
    regseason_games.each do |k, v|
      total = v.count
      goals_scored = hash[k][:regular_season][:total_goals_scored]
      unless goals_scored.zero?
        hash[k][:regular_season][:average_goals_scored] = (goals_scored.to_f / total.to_f).round(2)
      end
      goals_against = hash[k][:regular_season][:total_goals_against]
      unless goals_against.zero?
        hash[k][:regular_season][:average_goals_against] = (goals_against.to_f / total.to_f).round(2)
      end
    end
  return hash
end

  def games_by_team_type_and_season(team_id, type, seasons)
    games = {}
    seasons.each do |season|
      @games_data.each do |game|
        if game.season == season && (game.away_team_id == team_id || game.home_team_id == team_id) && game.type == type
          if games.has_key?(game.season)
            games[season] << game.game_id
          else
            games[season] = [game.game_id]
          end
        end
      end
    end
    return games
  end


end
