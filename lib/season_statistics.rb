module SeasonStatistics

  def biggest_bust(season) #tested line 253
    season = season.to_i
    preseason = wins_percentage(season, "P")
    regular = wins_percentage(season, "R")
    arr = {}
    regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.max_by { |k,v| v }
    team_id_name(biggest[0])
  end

  def biggest_surprise(season) #tested line 258
    preseason = wins_percentage(season.to_i, "P")
    regular = wins_percentage(season.to_i, "R")
    arr = {}
    regular.each do |key, value|
      if preseason.has_key?(key)
        arr[key] = (preseason[key] -= value)
      end
    end
    biggest = arr.min_by { |k,v| v }
    team_id_name(biggest[0])
  end






end
