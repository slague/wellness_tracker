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




end
