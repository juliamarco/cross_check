class TeamsData

  attr_reader :team_id,
              :franchise_id,
              :short_name,
              :team_name,
              :abbreviation,
              :link

  def initialize(teams_data)
    @team_id = teams_data[:team_id]
    @franchise_id = teams_data[:franchise_id]
    @short_name = teams_data[:short_name]
    @team_name = teams_data[:team_name]
    @abbreviation = teams_data[:abbreviation]
    @link = teams_data[:link]
  end

end
