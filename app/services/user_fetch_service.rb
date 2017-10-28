class UserFetchService

  def initialize(params)
    @query_params = params
  end

  def run
    return { error: "Query is only allowed param" } if !valid_params?
    results = User.all
    results.empty? ? results : { users: results }
  end
  alias results run

  private

  attr_reader :query_params

  def valid_params?
    permitted = query_params.permit(:query)
    permitted.permitted?
  end  
end
