class Search

  def initialize(query)
    @query = query
  end

  def run
    begin
      User.search { fulltext query }.results
    rescue Sunspot::IllegalSearchError
      raise MalformedError
    end
  end
  alias results run

  private

  attr_reader :query

end
