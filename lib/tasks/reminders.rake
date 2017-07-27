task :send_weekly_reminders => [:environment] do
  Reminder.send_monday_message if Date.today.cwday == 1
  Reminder.send_sunday_message if Date.today.cwday == 7
  # this is a test, remove before pushing to producation 
  Reminder.send_sunday_message if Date.today.cwday == 4
end
