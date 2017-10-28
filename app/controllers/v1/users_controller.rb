class V1::UsersController < ApplicationController
  def index
    render json: UserFetchService.new(params).results
  end

  def create
    render json: UserBuilder.new(params).run
  end
end
