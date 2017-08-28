class Mod < ApplicationRecord
  has_many :weeks
  has_many :users, through: :weeks
  has_many :goals, through: :weeks

  validates_presence_of :inning

  def self.weeks_without_winners
    no_winners =[]
    all.each do |mod|
      mod.weeks.each do |week|
        if week.winner == nil && week.ended?
          no_winners << week
        end
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

  def self.most_recent
    ends = []
    all.each do |mod|
     if mod.weeks.empty?
     else
       ends << mod.weeks.last.end_date
     end
   end
   nearest_date = ends.min_by {|date| (Date.today - date).abs }
   nearest_week = Week.where(end_date: nearest_date)
   nearest_week.first.mod
  end

  def mod_winners
    ended_weeks = weeks.select do |week|
      week.ended?
    end
    weeks_past = ended_weeks.count

    all_weekly_achievers = []
    ended_weeks.each do |week|
      all_weekly_achievers << User.achievers(week.id)
    end

    remove_empty = all_weekly_achievers.select do |arr|
      arr.any?
    end

    array_of_achievers = remove_empty.flatten
    counts = Hash.new(0)
    array_of_achievers.each do |user|
      counts["#{user.name}, #{user.cohort}"] += 1
    end

    mod_winners = counts.keys.select do |user|
      counts[user] == weeks_past
    end
    mod_winners
  end

end
