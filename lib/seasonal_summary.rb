module SeasonalSummary

def games_by_team_type_and_season(team_id, type, season) #tested 471
    @games_data.find_all do |game|
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

  end
