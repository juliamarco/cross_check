module TeamStatisticsHM

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

  # Helper Method
    def games_won_by_season(team_id) #tested line 299
      team_id = team_id.to_i
      games_by_season = games_played_by_season(team_id)
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


    # Helper Method
      def all_team_goals(team_id) #tested line 320
        @games_teams_stats.map do |stat|
          if stat.team_id == team_id
            stat.goals
          end
        end.compact
      end


      # Helper Method
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

      # Helper Method
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

      # Helper Method
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

        # Helper Method
          def get_goals_blowout(games) #tested lines 363
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
                game.away_team_id == team_id && game.home_team_id == opponent || game.home_team_id == team_id && game.away_team_id == opponent
              end
            end

            def games_won_against(team_id, opponent)
              @games_data.count do |game|
                game.away_team_id == team_id && game.home_team_id == opponent && game.outcome.include?("away") || game.home_team_id == team_id && game.away_team_id == opponent && game.outcome.include?("home")
              end
            end



end
