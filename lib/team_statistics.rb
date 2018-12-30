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


end
