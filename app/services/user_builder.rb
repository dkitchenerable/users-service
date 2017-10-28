class UserBuilder
  def initialize(params)
    @post_params = params
  end

  def run
    return { error: "Invalid params" } if invalid_params?
    new_user = User.create(@post_params)   
    new_user.persisted ? new_user : { errors: new_user.errors }
  end
  alias results run

  private

  attr_reader :post_params

  def invalid_params?
    params.permit(:email, :phone_number, :full_name, :password, :metadata)
    params.permitted?
  end
end
