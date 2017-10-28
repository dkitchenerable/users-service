class V1::UsersController < ApplicationController
  before_filter :validate_params

  def index
    results = UserFetchService.new(params).results
    render json: results,  status: 200
  end

  def create
    user = User.create(params)
    if user.persisted?
      render json: user, status: 201
    else
      render json: { errors: user.errors}, status: :bad_request
    end
  end

  private

  def validate_params
    permitted_params = request.method == "POST" ? permitted_post_params : permitted_get_params
    permitted = params.permit(permitted_params)
    render json: { invalid_params: permitted_params}, status: :bad_request if !permitted.permitted?
  end

  def permitted_post_params
    [:email, :phone_number, :full_name, :password, :metadata]
  end

  def permitted_get_params
    [:query]
  end
end
