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


end
