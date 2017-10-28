class AccountApiUnavailable < StandardError
  def initialize(msg="External Account Api Not Working")
    super
  end
end
