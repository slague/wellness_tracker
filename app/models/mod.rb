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





end
