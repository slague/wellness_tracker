
def stub_github_oath

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: 'github',
    extra: {
      raw_info: {
        uid: "1234",
        name: "Turing Student"
      }
    },
    credentials: {
      token: ENV['github_oauth_token'],
      secret: "thesecretsauce"
    },
    info: {
      nickname: "friend"
    }
    })

end

def login(user)
  stub_github_oath
  current_week = create :week
  visit root_path
  expect(page).to have_link("Sign in with GitHub")

  click_link('Sign in with GitHub')


  fill_in "Name", with: user.name
  fill_in "Cohort", with: user.cohort

  click_on "Update"
end
