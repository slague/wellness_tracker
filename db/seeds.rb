
# User.create
WeekNumber.create(name: "Week 1")
WeekNumber.create(name: "Week 2")
WeekNumber.create(name: "Week 3")
WeekNumber.create(name: "Week 4")
WeekNumber.create(name: "Week 5")
WeekNumber.create(name: "Week 6")

Mod.create(inning: "2017")
Week.create(start_date: Date.yesterday, end_date: (Date.today + 6), week_number: WeekNumber.last, mod_id: Mod.first)
# Goal.create(description: "Run 1 mile", total_goal_count: 2, user: User.last, week: Week.last, category: Category.last)


Category.create(name: "Sweat", image_path: "http://i.imgur.com/2qYIiM7.png")
Category.create(name: "Sleep", image_path: "http://i.imgur.com/bNdFoFG.png")
Category.create(name: "Personal", image_path: "http://i.imgur.com/9FNQsN9.png")
Category.create(name: "Nutrition", image_path: "http://i.imgur.com/OUbATwd.png")
