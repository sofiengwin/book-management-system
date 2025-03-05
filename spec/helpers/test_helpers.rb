module TestHelpers
  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end

  def token_for_user(user)
    ActionToken.encode(user.id)
  end
end
