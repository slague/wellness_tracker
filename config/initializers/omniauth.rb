Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
                  scope: 'user:email'
  # provider :census, ENV['census_id'], ENV['census_secret']
end
