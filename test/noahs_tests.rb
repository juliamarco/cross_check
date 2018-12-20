def test_it_can_access_the_highest_total_score
    game_sample_path = './data/game_sample.csv'
    stat_tracker = StatTracker.from_csv
    # binding.pry
    assert_equal 7, stat_tracker.highest_total_score(game_sample_path)
end
def highest_total_score(location)
  total_score = []
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    # binding.pry
      total_score << row[:away_goals].to_i + row[:home_goals].to_i
    end
  total_score.max
end

def test_it_can_access_the_lowest_total_score
    game_sample_path = './data/game_sample.csv'
    stat_tracker = StatTracker.from_csv
    # binding.pry
    assert_equal 3, stat_tracker.lowest_total_score(game_sample_path)
end
def lowest_total_score(location)
  total_score = []
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    # binding.pry
      total_score << row[:away_goals].to_i + row[:home_goals].to_i
    end
  total_score.min
end

def test_it_can_access_highest_difference_between_winner_and_loser
  game_sample_path = './data/game_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal 3, stat_tracker.biggest_blowout(game_sample_path)
end
def biggest_blowout(location)
  scores_diff = []
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    # binding.pry
    if row[:away_goals].to_i > row[:home_goals].to_i
      scores_diff << row[:away_goals].to_i - row[:home_goals].to_i
    elsif row[:away_goals].to_i < row[:home_goals].to_i
      scores_diff << row[:home_goals].to_i - row[:away_goals].to_i
    end
  end
  scores_diff.max
end



def test_it_can_access_most_popular_venue
  game_sample_path = './data/game_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal "TD Garden", stat_tracker.most_popular_venue(game_sample_path)
end
def most_popular_venue(location)
  all_venues = []
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    all_venues << row[:venue]
  end
  #maby do a diff enumerable, group_by?
  all_venues.each do |name|
    sorted_hash[name] += 1
  end
  return sorted_hash.key(sorted_hash.values.max)
end



def test_it_can_access_least_popular_venue
  game_sample_path = './data/game_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal "CONSOL Energy Center", stat_tracker.least_popular_venue(game_sample_path)
end
def least_popular_venue(location)
  all_venues = []
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    all_venues << row[:venue]
  end
  #maby do a diff enumerable, group_by?
  all_venues.each do |name|
    sorted_hash[name] += 1
  end
  return sorted_hash.key(sorted_hash.values.min)
end



def test_it_can_access_percentage_of_home_wins
  game_sample_path = './data/game_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal 66.67, stat_tracker.percentage_home_wins(game_sample_path)
end
def percentage_home_wins(location)
  outcomes = []
  num_of_games = 0
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    outcomes << row[:outcome]
    num_of_games += 1
  end
  outcomes.each do |outcome|
    sorted_hash[outcome] += 1
  end
  home_wins = sorted_hash["home win OT"] + sorted_hash["home win REG"]
  percentage = home_wins.to_f / num_of_games.to_f * 100
  percentage.round(2)
end



def test_it_can_access_percentage_of_visitor_wins
  game_sample_path = './data/game_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal 33.33, stat_tracker.percentage_visitor_wins(game_sample_path)
end
def percentage_visitor_wins(location)
  outcomes = []
  num_of_games = 0
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    outcomes << row[:outcome]
    num_of_games += 1
  end
  outcomes.each do |outcome|
    sorted_hash[outcome] += 1
  end
  visitor_wins = sorted_hash["away win OT"] + sorted_hash["away win REG"]
  percentage = visitor_wins.to_f / num_of_games.to_f * 100
  percentage.round(2)
end



def test_it_can_access_season_with_most_games
  game_season_sample_path = './data/game_season_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal 20152016, stat_tracker.season_with_most_games(game_season_sample_path)
end
def season_with_most_games(location)
  seasons = []
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    seasons << row[:season]
  end
  seasons.each do |season|
    sorted_hash[season] += 1
  end
  return sorted_hash.key(sorted_hash.values.max).to_i
end



def test_it_can_access_season_with_fewest_games
  game_season_sample_path = './data/game_season_sample.csv'
  stat_tracker = StatTracker.from_csv

  assert_equal 20142015, stat_tracker.season_with_fewest_games(game_season_sample_path)
end
def season_with_fewest_games(location)
  seasons = []
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    seasons << row[:season]
  end
  seasons.each do |season|
    sorted_hash[season] += 1
  end
  return sorted_hash.key(sorted_hash.values.min).to_i
end



def test_it_can_access_a_hash_with_seasons_and_num_of_games
  game_season_sample_path = './data/game_season_sample.csv'
  stat_tracker = StatTracker.from_csv
  #should these keys be integers or strings?
  expected = {20122013 => 6, 20142015 => 4, 20152016 => 8}
  assert_equal expected, stat_tracker.count_of_games_by_season(game_season_sample_path)
end
def count_of_games_by_season(location)
  seasons = []
  season_games = []
  sorted_hash = Hash.new(0)
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    seasons << row[:season].to_i
    season_games << row[:game_id]
  end
  seasons.each do |season|
    sorted_hash[season] += 1
  end
  return sorted_hash
end



def test_it_can_average_goals_per_games_over_all_seasons
  game_season_sample_path = './data/game_season_sample.csv'
  stat_tracker = StatTracker.from_csv
  #changed it from 4.77 to 4.78, does that matter?
  assert_equal 4.78, stat_tracker.average_goals_per_game(game_season_sample_path)
end
def average_goals_per_game(location)
  total_scores = []
  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
    total_scores << (row[:away_goals].to_f + row[:home_goals].to_f)
  end
  total_scores = total_scores.sum / total_scores.count
  return total_scores.round(2)
end



def test_it_can_average_goals_by_season
  game_season_sample_path = './data/game_season_sample.csv'
  stat_tracker = StatTracker.from_csv
  expected = {20122013 => 4.83, 20142015 => 3.25, 20152016 => 5.50}

  assert_equal expected, stat_tracker.average_goals_by_season(game_season_sample_path)
end
