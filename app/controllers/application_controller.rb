class ApplicationController < ActionController::API
  include Authentication

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :error_occurred

  def record_not_found(exception)
    render json: { error: exception.message }, status: 404
    return # rubocop:disable Style/RedundantReturn
  end

  def error_occurred(exception)
    render json: { error: exception.message }, status: 500
    return # rubocop:disable Style/RedundantReturn
  end
end
