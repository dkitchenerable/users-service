class MalformedError < StandardError
  def initialize(msg="Query Parameter Malformed")
    super
  end
end
