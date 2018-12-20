module GameStatistics

  def highest_total_score
   highest = @games_data.max_by do |game|
     game.away_goals + game.home_goals
   end
   return highest.home_goals + highest.away_goals
 end

 def lowest_total_score
   lowest = @games_data.min_by do |game|
     game.away_goals + game.home_goals
   end
   return lowest.home_goals + lowest.away_goals
 end

 def biggest_blowout
   all_nums = @games_data.map do |game|
     game.away_goals - game.home_goals
   end
   num = all_nums.max_by do |num|
     num.abs
   end
   return num.abs
 end

 def counts_venues_occurrences
   counts = Hash.new(0)
   #The argument is a default value argument that will be returned when a key that doesn’t correspond to a hash entry is accessed
   @games_data.each do |game|
     counts[game.venue] += 1
   end
   return counts
 end

 def most_popular_venue
   counts = counts_venues_occurrences
   max = counts.max_by do |key, value|
       value
   end
   return max[0]
 end

end
