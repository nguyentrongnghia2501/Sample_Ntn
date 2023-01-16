Slack.configure do |config|
  # config.token = xoxb-123432423-rgwrgerge-657567
  config.token = Rails.application.credentials.dig(:slack, :slack_api_token)
end
