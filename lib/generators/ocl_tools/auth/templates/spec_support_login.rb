module Login
  def mock_auth0_success(auth0_id, email: nil, email_verified: true)
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    opts = {
      "uid": auth0_id || "user-123",
      "info": {
        "email": email || "user@user.com",
        "first_name": "Bob",
        "last_name": "Userman",
      },
      "credentials": {
        "token": "XKLjnkKJj7hkHKJkk",
        "expires": true,
        "id_token": "eyJ0eXAiOiJK1VveHkwaTFBNXdTek41dXAiL.Wz8bwniRJLQ4Fqx_omnGDCX1vrhHjzw",
        "token_type": "Bearer",
      },
      "extra": {
        "raw_info": {
          "email_verified": email_verified,
        },
      },
    }

    OmniAuth.config.mock_auth[:auth0] = OmniAuth::AuthHash.new(opts)
  end

  def mock_auth0_failed
    OmniAuth.config.mock_auth[:auth0] = :invalid_credentials
  end

  def login_as(user = nil, email: nil, email_verified: true, invalid: false, auth0_id: nil)
    auth0_id ||= user.try(:auth0_id)
    invalid ? mock_auth0_failed : mock_auth0_success(auth0_id, email: email, email_verified: email_verified)
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:auth0]

    visit "/auth0_callback?code=vihipkGaumc5IVgs"
  end
end

RSpec.configure do |config|
  # include our macro
  config.include Login, type: :system
end

OmniAuth.config.test_mode = true
