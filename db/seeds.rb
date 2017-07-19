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
Category.create(name: "Sweat")
Goal.create(description: "Run 1 mile", total_goal_count: 2, user: User.last, week: Week.last, category: Category.last)


Category.create(name: "Sweat", image_path: File.new(Rails.root + "app/assets/images/fitness-icon.png"))
Category.create(name: "Sleep", image_path: File.new(Rails.root + "app/assets/images/rest-icon.png"))
Category.create(name: "Personal", image_path: File.new(Rails.root + "app/assets/images/personal-icon.png"))
Category.create(name: "Nutrition", image_path: File.new(Rails.root + "app/assets/images/nutrition-icon.png"))
 #<Category:0x007fa66deb7a38 id: 2, name: "Personal", created_at: Fri, 26 May 2017 19:07:54 UTC +00:00, updated_at: Fri, 26 May 2017 19:07:54 UTC +00:00, image_path: nil>,
 #<Category:0x007fa66deb78f8 id: 3, name: "Sleep", created_at: Fri, 26 May 2017 19:07:59 UTC +00:00, updated_at: Fri, 26 May 2017 19:07:59 UTC +00:00, image_path: nil>,
 #<Category:0x007fa66deb77b8 id: 4, name: "Nutrition", created_at: Fri, 26 May 2017 19:08:04 UTC +00:00, updated_at: Fri, 26 May 2017 19:08:04 UTC +00:00, image_path: nil>
