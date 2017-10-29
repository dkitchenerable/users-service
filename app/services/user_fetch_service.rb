class UserFetchService

  def initialize(params)
    @query = params[:query]
  end

  def run
    results = query.nil? ? User.all : search
    results.empty? ? results : { users: results }
  end
  alias results run

  private

  attr_reader :query

  def search
    User.search { fulltext query }.results      
  end

end
