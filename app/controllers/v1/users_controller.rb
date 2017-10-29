class V1::UsersController < ApplicationController
  def index
    results = UserFetchService.new(query_params).results
    render json: results,  status: 200
  end

  def create
    user = User.create(user_params)
    if user.persisted?
      render json: user, status: 201
    else
      render json: { errors: user.errors.full_messages }.to_json , status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :phone_number, :full_name, :password, :metadata)
  end

  def query_params
    params.permit(:query)
  end
end
