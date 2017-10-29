class UserFetchService

  def initialize(params)
    @query = params[:query]
  end

  def run
    results = query.nil? ? User.all : User.search { fulltext query }.results
    results.empty? ? results : { users: results }
  end
  alias results run

  private

  attr_reader :query
end
