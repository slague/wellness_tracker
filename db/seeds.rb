# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create
WeekNumber.create(name: "Week 1")
Week.create(start_date: Date.yesterday, end_date: Date.today, week_number: WeekNumber.last)
# Category.create(name: "Sweat")
# Goal.create(description: "Run 1 mile", total_goal_count: 2, user: User.last, week: Week.last, category: Category.last)


Category.create(name: "Sweat", image_path: "http://i.imgur.com/2qYIiM7.png")
Category.create(name: "Sleep", image_path: "http://i.imgur.com/bNdFoFG.png")
Category.create(name: "Personal", image_path: "http://i.imgur.com/9FNQsN9.png")
Category.create(name: "Nutrition", image_path: "http://i.imgur.com/OUbATwd.png")
