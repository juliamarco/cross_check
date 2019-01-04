module TeamStatistics

  def team_info(team_id) #tested line 293
    team = @teams_data.find do |team|
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

<<<<<<< HEAD
 # Helper Method
  def games_played_by_season(team_id)
    games_by_season = @games_data.group_by { |game| game.season }
      games_by_season.each do |season,games|
        all_games_played = games.find_all do |game|
          game.home_team_id == team_id || game.away_team_id == team_id
        end
        games_by_season[season] = all_games_played.map { |game| game.game_id }
      end
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

=======
>>>>>>> ab533da114711cefad79fbcb158a2e7330172ceb
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
    team_id = team_id.to_i
    total_games_played = @games_teams_stats.count {|stat| stat.team_id == team_id}
    total_games_won = @games_teams_stats.count {|stat| stat.team_id == team_id && stat.won == "TRUE"}
    (total_games_won.to_f / total_games_played.to_f).round(2)
  end

  def most_goals_scored(team_id) #tested line 325
    all_team_goals(team_id.to_i).max
  end

  def fewest_goals_scored(team_id) #tested line 330
    all_team_goals(team_id.to_i).min
  end

  def favorite_opponent(team_id) #tested line 353
    hash = Hash.new
    get_opponents_results(team_id.to_i, hash)
    team = calculate_percentages(hash).min_by { |k,v| v }[0]
    team_id_name(team)
  end

  def rival(team_id) #tested line 358
    hash = Hash.new
    get_opponents_results(team_id.to_i, hash)
    team = calculate_percentages(hash).max_by { |k, v| v }[0]
    team_id_name(team)
  end

  def biggest_team_blowout(team_id) #tested line 369
    team_id = team_id.to_i
    games_won = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "TRUE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_won).max
  end

  def worst_loss(team_id) #tested line 374
    team_id = team_id.to_i
    games_lost = @games_teams_stats.map do |stat|
      if stat.team_id == team_id && stat.won == "FALSE"
        stat.game_id
      end
    end.compact
    get_goals_blowout(games_lost).max
  end

<<<<<<< HEAD
 # Helper Method
  def all_opponents(id)
    @games_data.map do |game|
      if game.away_team_id == id
        game.home_team_id
      elsif game.home_team_id == id
        game.away_team_id
      end
    end.compact.uniq
  end

 # Helper Method 
  def games_played_against(team_id, opponent)
    @games_data.count do |game|
      game.away_team_id == team_id && game.home_team_id == opponent || game.home_team_id == team_id && game.away_team_id == opponent
    end
  end

 # Helper Method
  def games_won_against(team_id, opponent)
    @games_data.count do |game|
      game.away_team_id == team_id && game.home_team_id == opponent && game.outcome.include?("away") || game.home_team_id == team_id && game.away_team_id == opponent && game.outcome.include?("home")
    end
  end

=======
>>>>>>> ab533da114711cefad79fbcb158a2e7330172ceb
  def head_to_head(team_id) #tested line 379
    team_id = team_id.to_i
    head_to_head = {}
    opponents = all_opponents(team_id)
    opponents.each do |opponent|
      games_played = games_played_against(team_id, opponent)
      games_won = games_won_against(team_id, opponent)
      percentage = (games_won.to_f / games_played.to_f).round(2)
      head_to_head[team_id_name(opponent)] = percentage
    end
    return head_to_head
  end

<<<<<<< HEAD
 # Helper Method
  def games_by_team_type_and_season(team_id, type, season) #tested 471
      @games_data.find_all do |game|
        game.season == season && (game.away_team_id == team_id || game.home_team_id == team_id) && game.type == type
      end
  end
  
 # Helper Method
  def seasons_played_by_team(team_id)
    @games_data.map do |game|
      if game.away_team_id == team_id || game.home_team_id == team_id
        game.season
      end
    end.compact.uniq
  end

 # Helper Method
  def create_seasonal_summary_hash(seasons)
    seasonal_summary = Hash.new(0)
    seasons.each do |season|
      season = season.to_s
      seasonal_summary[season] = {:preseason =>
                                    {:win_percentage => 0,
                                      :total_goals_scored => 0,
                                      :total_goals_against => 0,
                                      :average_goals_scored => 0,
                                      :average_goals_against => 0},
                                      :regular_season =>
                                    {:win_percentage => 0,
                                      :total_goals_scored => 0,
                                      :total_goals_against => 0,
                                      :average_goals_scored => 0,
                                      :average_goals_against => 0}}
    end
    return seasonal_summary
  end

  def seasonal_summary(team_id)
    team_id = team_id.to_i
    team = @teams_data.find {|team| team.team_id == team_id}
    seasons = seasons_played_by_team(team_id)
    seasonal_summary = create_seasonal_summary_hash(seasons)
    seasonal_summary.each do |season,stats|
      season = season.to_i
      summary_hash = season_summary(season, team_id)
      pre_goals_scored = summary_hash[:preseason][:goals_scored]
      pre_goals_against = summary_hash[:preseason][:goals_against]
      reg_goals_scored = summary_hash[:regular_season][:goals_scored]
      reg_goals_against = summary_hash[:regular_season][:goals_against]
      all_pre_games = games_by_team_type_and_season(team_id, "P", season).count.to_f
      all_reg_games = games_by_team_type_and_season(team_id, "R", season).count.to_f
      stats[:preseason][:win_percentage] = summary_hash[:preseason][:win_percentage]
      stats[:preseason][:total_goals_scored] = pre_goals_scored
      stats[:preseason][:total_goals_against] = pre_goals_against
      if pre_goals_scored == 0 && all_pre_games == 0
        stats[:preseason][:average_goals_scored] = 0.0
      else
        stats[:preseason][:average_goals_scored] = (pre_goals_scored / all_pre_games).round(2)
      end
      if pre_goals_against == 0 && all_pre_games == 0
        stats[:preseason][:average_goals_against] = 0.0
      else
        stats[:preseason][:average_goals_against] = (pre_goals_against / all_pre_games).round(2)
      end
      stats[:regular_season][:win_percentage] = summary_hash[:regular_season][:win_percentage]
      stats[:regular_season][:total_goals_scored] = reg_goals_scored
      stats[:regular_season][:total_goals_against] = reg_goals_against
      if reg_goals_scored == 0 && all_reg_games == 0
        stats[:regular_season][:average_goals_scored] = 0.0
      else
        stats[:regular_season][:average_goals_scored] = (reg_goals_scored / all_reg_games).round(2)
      end
      if reg_goals_against == 0 && all_reg_games == 0
        stats[:regular_season][:average_goals_against] = 0.0
      else
        stats[:regular_season][:average_goals_against] = (reg_goals_against / all_reg_games).round(2)
      end
  end
  return seasonal_summary
end

=======
>>>>>>> ab533da114711cefad79fbcb158a2e7330172ceb
end
