class UserFetchService
  def initialize(params)
    @query = params[:query]
  end

  def run
    results = query.nil? ? User.all : search
    results.empty? ? results : { users: serialize(results)}
  end
  alias results run

  private

  attr_reader :query

  def search
    begin 
      User.search { fulltext query }.results
    rescue Sunspot::IllegalSearchError
      raise MalformedError
    end
  end

  def serialize(results)
    ActiveModel::Serializer::CollectionSerializer.new(results, each_serializer: UserSerializer)
  end
end
