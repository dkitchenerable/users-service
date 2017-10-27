class V1::UsersController < ApplicationController
  def index
    render User.all.to_json
  end

  def create
    render '{}'
  end

end
