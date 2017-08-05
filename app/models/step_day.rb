class StepDay < ApplicationRecord
  belongs_to :user

  scope :ordered, ->{ order(date: :asc) }
  scope :since, ->(date) { ordered.where("date > ?", date) }
end
