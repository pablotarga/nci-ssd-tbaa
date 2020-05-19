class Task < ApplicationRecord
  include Schedulable
  belongs_to :project
  has_one :advisor, through: :project
  has_one :student, through: :project

  enum priority: [:high, :medium, :normal, :low]
  enum status: [:pending, :in_progress, :review, :rejected, :done, :completed] # completed =>  done done

  validates :title, :priority, :status, presence: true

  scope :displayable, ->{ where(status: %w[pending in_progress review done]) }
  scope :active, ->{ where.not(status: 'rejected')  }
  scope :finished, ->{ where(status: %w[completed done])  }
end
