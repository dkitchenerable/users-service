class ApplicationController < ActionController::API
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :general_error
  rescue_from ::ActionController::RoutingError, with: :general_error
  rescue_from ::MalformedError, with: :malformed

  private

  def record_not_found(e)
    render json: {error: e.message}.to_json, status: 404
  end

  def general_error(e)
    render json: {error: e.message}.to_json, status: 500
  end

  def malformed_error(e)
    render json: { errors: e.message}.to_json, status: 422
  end
end
