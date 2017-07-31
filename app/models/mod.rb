class Mod < ApplicationRecord
  has_many :weeks

  def weeks_without_winners
    no_winners =[]
    weeks.each do |week|
      if week.winner == nil && week.ended?
        no_winners << week
      end
    end
    no_winners
  end

  def has_six_weeks?
    weeks.count == 6
  end

  def fewer_than_six_weeks?
    weeks.count < 6
  end


  def self.incomplete_mods
    incomplete = []
    all.each do |mod|
      if mod.fewer_than_six_weeks?
        incomplete << mod
      end
    end
    incomplete
  end



      # MOD WINNERS
      # We'll need a way to see who has achieved 100% of goals each week of the current mod
      # something like......
      # current_mod.weeks.each do |week|
      # User.achievers(week)
      # all users who achieve 100% of goals every week of hte mod win an end of mod prize!

      # so we’d want to select all students from a specific mod filtered by them achieving their goals for each individual week
      #
      # ok! i can see something on “mod” that looks through each of it’s students and determines if they’ve achieved all their goals for each week in the mod
      #
      # you would need the week id’s though


end
