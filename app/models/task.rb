class Task < ApplicationRecord
  belongs_to :project
  has_one :advisor, through: :project
  has_one :student, through: :project

  enum priority: [:high, :medium, :normal, :low]
  enum status: [:pending, :in_progress, :review, :completed, :rejected, :done, :closed]

  validates :title, :priority, :status, presence: true
end
