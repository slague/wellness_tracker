class Week < ApplicationRecord
  belongs_to :week_number
  has_many :goals
  has_many :users, through: :goals

  validates :start_date, :end_date, presence: true

  def self.set_weeks(num_of_weeks, weeks_start)
    week_nums = [*1..num_of_weeks]
    starts_ends = {}
    start = weeks_start
    week_nums.each do |num|
      starts_ends[num] = [start, start+6]
      start +=7
    end
    starts_ends.each do |num, dates|
      Week.create(week_number_id: num, start_date: dates.first, end_date: dates.last)
    end
  end

  def self.get_start_dates
    all.map { |week| week.start_date}
  end

  def self.get_end_dates
    all.map { |week| week.end_date}
  end
end
