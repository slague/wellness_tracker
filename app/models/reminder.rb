class Reminder < ApplicationRecord

  def self.send_confirmation_message(user)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.messages.create(
      from: @twilio_number,
      to:  user.sanitize_phone_number,
      body: "You've signed up for reminder texts from the Turing Wellness Tracker. You will receive a reminder at the start of the week to set your goals, and a reminder at the end of the week to submit your goals. To opt of texts visit the Wellness Tracker website."
      )
  end



  def send_monday_message
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    User.text_recipients.each do |user|

    @client.messages.create(
      from: @twilio_number,
      to:   user.sanitize_phone_number,
      body: "It's a new week. Remember to set your Wellness Goals!"
      )
    end
  end

  def send_sunday_message
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.messages.create(
      from: @twilio_number,
      to:  User.text_recients.each { |user| user.sanitize_phone_number },
      body: "Remember to submit your Wellness Goals by the end of the day!"
      )
  end


  def run_monday
    Week.get_start_dates
    # this gets all of the start dates
    # add time - 9:00 AM MST
  end


  def run_sunday
    Week.get_end_dates
    # this gets all of the end dates
    # add time - 6:00 PM MST
  end

  handle_asynchronously :send_monday_message, :run_at => Proc.new { |i| i.run_monday }
  handle_asynchronously :send_sunday_message, :run_at => Proc.new { |i| i.run_sunday }
end
