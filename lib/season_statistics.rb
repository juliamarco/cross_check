module SeasonStatistics

  def game_by_type(type)
    games = []
    @games_data.each do |game|
      if game.type == type
        games << game.game_id
      end
    end
    games
  end

  def biggest_bust
  end

  def biggest_surprise
  end

  def season_summary
  end

end
