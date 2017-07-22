class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :weeks, through: :goals

  enum role: %w(default admin)
  enum wants_reminder: %w(0 1)

  validates :github_id, presence: true

  scope :text_recipients, -> { where(wants_reminder: "1") }


  def send_reminder
    @twilio_number = ENV['TWILIO_NUMBER']

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create({
      :from => @twilio_number,
      :to => '+14145179678',
      :body => 'I sent you a fucking sms!',
    })

  end

end
