class UserFetchService

  def initialize(params)
    @query_params
  end

  def run
    results = User.all
    results.empty? ? results : { users: results }
  end
  alias results run

  private

  attr_reader :query_params

  def invalid_params?
    params.permit(:query)
    params.permitted?
  end  
end
