module SeasonStatistics

  def biggest_bust(season)
    season = season.to_i
    preseason = wins_percentage(season, "P")
    regular = wins_percentage(season, "R")
    biggest_bust = Hash.new
    regular.each do |team_id, percentage|
      if preseason.has_key?(team_id)
        biggest_bust[team_id] = (preseason[team_id] -= percentage)
      end
    end
    biggest = biggest_bust.max_by { |team_id, percentage| percentage }
    team_id_name(biggest[0])
  end

  def biggest_surprise(season)
    preseason = wins_percentage(season.to_i, "P")
    regular = wins_percentage(season.to_i, "R")
    biggest_surprise = Hash.new
    regular.each do |team_id, percentage|
      if preseason.has_key?(team_id)
        biggest_surprise[team_id] = (preseason[team_id] -= percentage)
      end
    end
    biggest = biggest_surprise.min_by { |team_id, percentage| percentage }
    team_id_name(biggest[0])
  end

end
