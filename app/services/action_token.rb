require "jwt"

module ActionToken
  ALGORITHM = "HS256"

  SIGNING_KEY = Rails.application.key_generator.generate_key("action-token")

  def self.encode(user_id)
    payload = {
      sub: user_id,
      iat: Time.now.to_i,
      exp: Time.now.to_i + (60 * 60)
    }

    JWT.encode(payload, SIGNING_KEY, ALGORITHM)
  end

  def self.decode(str)
    claims, _header = JWT.decode(str, SIGNING_KEY, false, { algorithm: ALGORITHM })

    claims
  end
end
