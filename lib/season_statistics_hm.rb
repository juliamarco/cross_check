module SeasonStatisticsHM

    def games_by_season(season) #tested line 235
      season = season.to_i
      games = @games_data.find_all { |game| game.season == season }
      games.map { |game| game.game_id }
    end

    def game_by_type(season, type) #tested line 241
      games = games_by_season(season)
      games = @games_data.map do |game|
        if games.include?(game.game_id)
          if game.type == type
            game.game_id
          end
        end
      end.compact
    end


        def away_goals_scored(games, team_id) #tested line 263
        away_goals_scored = 0
        @games_data.each do |game|
          if games.include?(game.game_id)
            if game.away_team_id == team_id
              away_goals_scored += game.away_goals
            end
          end
        end
        return away_goals_scored
      end

        def home_goals_allowed(games, team_id) #tested line 281
        home_goals_allowed = 0
        @games_data.each do |game|
          if games.include?(game.game_id)
            if game.home_team_id == team_id
              home_goals_allowed += game.away_goals
            end
          end
        end
        return home_goals_allowed
      end

      def team_games(games, team_id)
        @games_teams_stats.find_all do |game|
          games.include?(game) && game.team_id == team_id
        end
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

        def calculate_percentages(hash) #tested line 190/195
          values = hash.values
          won_outcomes = values.map {|value| value.count("TRUE")}
          total_outcomes = values.map {|value| value.count}
          percentages = Hash.new
          hash.each do |key, value|
            if value.include?("TRUE")
              percentages[key] = (won_outcomes[0].to_f / total_outcomes[0].to_f)
              won_outcomes.shift
              total_outcomes.shift
            else
              percentages[key] = 0.0
              won_outcomes.shift
              total_outcomes.shift
            end
          end
          return percentages
        end

end
