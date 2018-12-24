class TeamsData

  attr_reader :team_id,
              :franchiseId,
              :shortName,
              :teamName,
              :abbreviation,
              :link

  def initialize(teams_data)
    @team_id = teams_data[:team_id]
    @franchiseId = teams_data[:franchiseId]
    @shortName = teams_data[:shortName]
    @teamName = teams_data[:teamName]
    @abbreviation = teams_data[:abbreviation]
    @link = teams_data[:link]
  end

end
