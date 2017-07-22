class Reminder < ApplicationRecord

  # validates :phone_number, presence: true
  # validates :time, presence: true



  def send_message

    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => phone_number,
      :body => alert_message,
     # US phone numbers can make use of an image as well.
     # :media_url => image_url
    )
    puts message.to
  end


#   def monday_reminder
#     @twilio_number = ENV['TWILIO_NUMBER']
#     account_sid = ENV['TWILIO_ACCOUNT_SID']
#     @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
#     # time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
#     reminder = "Remember to set your Wellness Goals for the week!"
#     message = @client.api.account(account_sid).messages.create(
#       :from => @twilio_number,
#       # :to => all the numbers that have opted in...
#       :body => reminder,
#     )
#   end
#
#   def sunday_reminder
#     @twilio_number = ENV['TWILIO_NUMBER']
#     account_sid = ENV['TWILIO_ACCOUNT_SID']
#     @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
#     # time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
#     reminder = "Remember to submit your Wellness Goals by the end of the day!"
#     message = @client.api.account(account_sid).messages.create(
#       :from => @twilio_number,
#       # :to => all the numbers that have opted in...
#       :body => reminder,
#     )
#   end
#
#
#
#   def when_to_run
#     # Monday of each week
#     # Sunday of each week
#
#     # minutes_before_appointment = 30.minutes
#     # time - minutes_before_appointment
#   end
#
# end
