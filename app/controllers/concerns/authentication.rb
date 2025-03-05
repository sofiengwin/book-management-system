module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def authenticated?
    resume_session
  end

  def require_authentication
    current_user || request_authentication
  end

  def request_authentication
    render json: { error: "Unauthorized" }, status: :unauthorized
    return # rubocop:disable Style/RedundantReturn
  end

  def current_user
    @current_user ||= find_current_user_from_token
  end

  def find_current_user_from_token
    return unless current_user_id

    User.find_by(id: current_user_id)
  end

  def bearer_token
    request.headers["Authorization"]&.split&.last
  end

  def current_user_id
    return if bearer_token.blank?

    claim = ActionToken.decode(bearer_token)
    claim["sub"]
  rescue JWT::InvalidAudError, JWT::InvalidIssuerError, JWT::DecodeError, JWT::ExpiredSignature
    nil
  end
end
