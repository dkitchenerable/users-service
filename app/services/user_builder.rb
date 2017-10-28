class UserBuilder
  def initialize(params)
    @post_params = params
  end

  def run
    return { error: "only valid params: email, phone_number, full_name, password, metadata" } if !valid_params?
    new_user = User.create(@post_params)   
    new_user.persisted ? new_user : { errors: new_user.errors }
  end
  alias results run

  private

  attr_reader :post_params

  def valid_params?
    permitted = post_params.permit(:email, :phone_number, :full_name, :password, :metadata)
    permitted.permitted?
  end
end
