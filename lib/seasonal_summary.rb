module SeasonalSummary

  def count_games_by_team_type_and_season(team_id, type, season)
      @games_data.count do |game|
        # binding.pry
        game.season == season && (game.away_team_id == team_id || game.home_team_id == team_id) && game.type == type
      end
  end

  def seasons_played_by_team(team_id)
    @games_data.map do |game|
      if game.away_team_id == team_id || game.home_team_id == team_id
        game.season
      end
    end.compact.uniq
  end



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
          all_pre_games = count_games_by_team_type_and_season(team_id, "P", season).to_f
          all_reg_games = count_games_by_team_type_and_season(team_id, "R", season).to_f
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

    def season_summary(season, team_id) #tested line 287
      season = season.to_i
      team_id = team_id.to_i
      summary = {:preseason => {}, :regular_season => {}}
      pre_wins_percent = wins_percentage(season, "P")
      reg_wins_percent = wins_percentage(season, "R")
        if pre_wins_percent.include?(team_id)
          summary[:preseason][:win_percentage] = pre_wins_percent.find {|team,wins| team == team_id}[1].round(2)
        else summary[:preseason][:win_percentage] = 0.0
        end
        if reg_wins_percent.include?(team_id)
          summary[:regular_season][:win_percentage] = reg_wins_percent.find {|team,wins| team == team_id}[1].round(2)
        else summary[:preseason][:win_percentage] = 0.0
        end
      preseason_games = game_by_type(season, "P")
      p_goals_scored = away_goals_scored(preseason_games, team_id) + home_goals_scored(preseason_games, team_id)
      summary[:preseason][:goals_scored] = p_goals_scored
      p_goals_allowed = away_goals_allowed(preseason_games, team_id) + home_goals_allowed(preseason_games, team_id)
      summary[:preseason][:goals_against] = p_goals_allowed
      regular_season_games = game_by_type(season, "R")
      r_goals_scored = away_goals_scored(regular_season_games, team_id) + home_goals_scored(regular_season_games, team_id)
      summary[:regular_season][:goals_scored] = r_goals_scored
      r_goals_allowed = away_goals_allowed(regular_season_games, team_id) + home_goals_allowed(regular_season_games, team_id)
      summary[:regular_season][:goals_against] = r_goals_allowed
      return summary
    end

  end
