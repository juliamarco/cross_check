module TeamStatistics

  def team_info(team_id) #tested line 293
    team = @teams_data.find do |team|
      # binding.pry
      team.team_id == team_id.to_i
    end
    new = Hash.new(0)
    new["team_id"] = team.team_id.to_s
    new["franchise_id"] = team.franchise_id.to_s
    new["short_name"] = team.short_name
    new["team_name"] = team.team_name
    new["abbreviation"] = team.abbreviation
    new["link"] = team.link
    return new
  end

  def games_won_by_season(team_id) #tested line 299
    team_id = team_id.to_i
    games_by_season = @games_data.group_by { |game| game.season }
      games_by_season.each do |season,games|
        all_games_played = games.find_all do |game|
          game.home_team_id == team_id || game.away_team_id == team_id
        end
        games_by_season[season] = all_games_played.map { |game| game.game_id }
      end
      games_by_season = games_by_season.reject { |season,games| games.empty? }
      games_by_season.each do |season,games|
        @games_teams_stats.map do |stat|
          if games.include?(stat.game_id)
            if stat.team_id == team_id
              games_by_season[season].push(stat.won)
            end
          end
        end
      end
      games_by_season.each do |season,games|
        game_results = games.reject { |game| game.is_a?(Numeric) }
        games_by_season[season] = game_results
      end
  end

  def best_season(team_id) #tested line 305
    games_results = games_won_by_season(team_id)
    best_season = calculate_percentages(games_results).max_by do
     |season,outcome| outcome
    end[0]
    best_season.to_s
  end

  def worst_season(team_id) #tested line 310
    games_results = games_won_by_season(team_id)
    best_season = calculate_percentages(games_results).min_by do
     |season,outcome| outcome
    end[0]
    best_season.to_s
  end

  def average_win_percentage(team_id) #tested line 315
    games = games_won_by_season(team_id)
    percentages = calculate_percentages(games)
    (percentages.sum { |k,v| v }) / percentages.count
  end

  def all_team_goals(team_id) #tested line 320
    @games_teams_stats.map do |stat|
      if stat.team_id == team_id
        stat.goals
      end
    end.compact
  end

  def most_goals_scored(team_id) #tested line 325
    all_team_goals(team_id).max
  end

  def fewest_goals_scored(team_id) #tested line 330
    all_team_goals(team_id).min
  end

  def collect_home_games_opponents(team_id, hash) #tested line 335
    @games_data.each do |game|
      if game.home_team_id == team_id
        if hash.has_key?(game.away_team_id)
          hash[game.away_team_id] << game.game_id
        else
          hash[game.away_team_id] = [game.game_id]
        end
      end
    end
  return hash
  end

  def collect_away_games_opponents(team_id, hash) #tested line 341
    @games_data.each do |game|
      if game.away_team_id == team_id
        if hash.has_key?(game.home_team_id)
          hash[game.home_team_id] << game.game_id
        else
          hash[game.home_team_id] = [game.game_id]
        end
      end
    end
    return hash
  end

  def get_opponents_results(team_id, hash) #tested line 347
    collect_home_games_opponents(team_id, hash)
    collect_away_games_opponents(team_id, hash)
    hash.each do |k,v|
      values = @games_teams_stats.map do |stat|
        if k == stat.team_id && v.include?(stat.game_id)
          stat.won
        end
      end.compact
    hash[k] = values
    end
  end

  def favorite_opponent(team_id) #tested line 353
    hash = Hash.new
    get_opponents_results(team_id, hash)
    team = calculate_percentages(hash).min_by { |k,v| v }[0]
    team_id_name(team)
  end

  def rival(team_id) #tested line 358
    hash = Hash.new
    get_opponents_results(team_id, hash)
    team = calculate_percentages(hash).max_by { |k,v| v }[0]
    team_id_name(team)
  end

  def get_goals_blowout(games) #tested lines 363
    @games_data.map do |game|
      if games.include?(game.game_id)
        (game.away_goals - game.home_goals).abs
      end
    end.compact
  end

  def biggest_team_blowout(team_id) #tested line 369
    games_won = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "TRUE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_won).max
  end

  def worst_loss(team_id) #tested line 374
    games_lost = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "FALSE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_lost).max
  end

  def head_to_head(team_id) #tested line 379
    hash = {}
    @games_teams_stats.each do |stat|
      unless stat.team_id == team_id
        if hash.has_key?(stat.team_id)
          hash[stat.team_id] << stat.won
        else
          hash[stat.team_id] = [stat.won]
        end
      end
    end
    new_hash = {}
    percentages = calculate_percentages(hash)
      percentages.each do |team_id,win_percent|
        team_name = team_id_name(team_id)
        new_hash[team_name] = (1 - win_percent).round(2)
      end
    return new_hash
  end

  def get_wins_percentages_into_hash(seasons_played, team_id, hash) #tested 386
    seasons_played.each do |season|
      hash[season][:preseason][:win_percentage] = wins_percentage(season,"P").find { |k,v| k == team_id }[1]
      hash[season][:regular_season][:win_percentage] = wins_percentage(season,"R").find { |k,v| k == team_id }[1]
    end
    return hash
  end

  def games_by_team_type_and_season(team_id, type, seasons) #tested 471
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

  def seasonal_summary(team_id) #tested line 477
    seasons_played = @games_data.map do |game|
      if game.away_team_id == team_id || game.home_team_id == team_id
        game.season
      end
    end.compact.uniq
    hash = Hash.new(0)
    seasons_played.each do |season|
      hash[season] = {:preseason => {:win_percentage => 0,
                                     :total_goals_scored => 0,
                                     :total_goals_against => 0,
                                     :average_goals_scored => 0,
                                     :average_goals_against => 0},
                      :regular_season => {:win_percentage => 0,
                                          :total_goals_scored => 0,
                                          :total_goals_against => 0,
                                          :average_goals_scored => 0,
                                          :average_goals_against => 0} }
    end
    get_wins_percentages_into_hash(seasons_played, team_id, hash)
    preseason_games = games_by_team_type_and_season(team_id, "P", seasons_played)
    regseason_games = games_by_team_type_and_season(team_id, "R", seasons_played)
    preseason_games.each do |k, v|
      @games_teams_stats.each do |game|
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
    binding.binding.pry
    return hash
  end

end
