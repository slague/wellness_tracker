# README

* Overview

This app is designed for Turing Students to track their wellness goals.  It replaces a school-wide spreadsheet. Goals can be set each week in four categories: "Nutrition", "Personal", "Sleep", and "Sweat". A student sets his or her own goals on Monday of each week. Students can create goals for each category (as many goals as they like per week per category, with no more than a count of 7-one for each day of the week- for each individual goal).  Goals must be marked completed by the end of the day on Sunday.  Goals do not reset at the start of each new week. A user must enter his or her goals each week.


## Tech stack
 This is a Rails 5.0.0.1 application

## Setup

 Clone the repo

 Run `bundle`
 `rake db:create`
 `rake db:migrate`
 `rake db:seed`


 * In order to authenticate, you will need to set up GitHub OAuth and add the appropriate environment variables to the .env files.

 * In order to implement text messaging, you will need to setup a Twilio Account and add the appropriate environment variables to the .env files. Note that in order to send sms messages from your local machine, you will need to use your actual Twilio phone number. The test number will not send texts.

 * To run locally run `rails s` and open browser to http://127.0.0.1:3000/ (not localhost!)

 * The seeds will create all four goal categories, six "week numbers", and one dummy mod with one "week". You will need to either add mods and weeks manually or in the browser in order to create a more realistic 6-week Mod.  

 * The staging and production applications use Heroku scheduler to send weekly reminder texts.
 Add the rake task `rake send_weekly_reminders` to Heroku scheduler to recreate.
 Delayed_job is also included in this application, but is not currently being used to send delayed texts.

### Testing

This app uses Rspec for testing. To run tests `rspec`

### Production Site
This application is currently under development. This README will be updated as progress is made and the app is deployed to production.  
* [Staging Link](https://well-track-staging.herokuapp.com)
* [Production Link](https://turing-wellness-tracker.herokuapp.com/)
