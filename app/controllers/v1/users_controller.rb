class V1::UsersController < ApplicationController
  def index
    # alternate
      # service = UserFetchService.new(params)
      # if service.valid?
      #   render json: service.results
      # else
      #   render json: { errors: service.errors}, status: :bad_request
      # end
    render json: UserFetchService.new(params).results
  end

  def create
    # alternate
      # builder = UserBuilder.(params).build
      # if builder.valid?
      #   render json: builder.results, status: 201
      # else
      #   render json: { errors: builder.errors} status: :bad_request
      # end
    render json: UserBuilder.new(params).results
  end
end
