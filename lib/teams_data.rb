class TeamsData

  attr_reader :team_id,
              :franchiseId,
              :shortName,
              :teamName,
              :abbreviation,
              :link

  def initialize(row)
    @team_id = row[0]
    @franchiseId = row[1]
    @shortName = row[2]
    @teamName = row[3]
    @abbreviation = row[4]
    @link = row[5]
  end

end
