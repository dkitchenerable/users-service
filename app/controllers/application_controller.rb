class ApplicationController < ActionController::API
  # catch errors outside of validation and invalid params
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :general_error
  rescue_from ::ActionController::RoutingError, with: :general_error

  private

  def record_not_found(exception)
    render json: {error: exception.message}.to_json, status: 404
  end

  def general_error(exception)
    render json: {error: exception.message}.to_json, status: 500
  end
end
