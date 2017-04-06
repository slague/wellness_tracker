class User < ApplicationRecord
  has_many :goals
  has_many :weeks, through: :goals

end
