class Project < ApplicationRecord
  belongs_to :advisor, class_name: 'User'
  belongs_to :student, class_name: 'User', optional: true

  delegate :name, :email, to: :advisor, prefix: true
  delegate :name, :email, to: :student, prefix: true

  enum status: [:draft, :in_progress, :submitted, :approved, :rejected]

  scope :published, ->{ where.not(status: 'draft') }

  before_validation :set_short_description

  validates :due_at, presence: true, if: :published?
  validates :title, :description, :short_description, presence: true
  validates :title, :description, :short_description, length: {minimum: 10}, allow_blank: true
  validates :short_description, length: {maximum: 30}, allow_blank: true
  validate :ensure_due_at_is_future, if: :due_at_changed?

  def published?
    !draft?
  end

  private

  def set_short_description
    self.short_description = self.description.to_s[0...30] unless short_description.present?
  end

  def ensure_due_at_is_future
    errors.add :due_at, 'must be in the future' if due_at && due_at.past?
  end


end
