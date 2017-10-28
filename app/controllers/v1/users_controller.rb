class V1::UsersController < ApplicationController
  def index
    # refactor out to service
    @results = User.all
    if @results.empty?
      render json: @results
    else
      render json: { users: @results }
    end
  end

  def create
    new_user = User.create(user_params)
    if new_user.persisted?
    else
    end
  end

  private

  def user_params
  end

end
