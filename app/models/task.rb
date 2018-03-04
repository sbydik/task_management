class Task < ApplicationRecord  
  enum status: { unstarted: 0, ongoing: 1, finished: 2 }
  enum priority: { low: 0, middle: 1, high: 2, highest: 3 }

  default_scope { order(deadline: :asc, priority: :desc) }

  validates :subject,
    presence: true,
    length: { maximum: 255 }

  validates :priority,
    presence: true
end
