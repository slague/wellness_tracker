class RemindersController < ApplicationController


  def send_reminder(user)
    @twilio_number = ENV['TWILIO_NUMBER']

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    @client.account.messages.create({
      :from => @twilio_number,
      :to => "+#{user.phone_number}",
      :body => 'I sent you an sms!',
    })

  end

end
