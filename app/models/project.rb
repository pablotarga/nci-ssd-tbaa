class Project < ApplicationRecord
  include Schedulable

  belongs_to :advisor, class_name: 'User'
  belongs_to :student, class_name: 'User', optional: true

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, reject_if: ->(a){ a['title'].blank? }, allow_destroy: true

  delegate :name, :email, to: :advisor, prefix: true
  delegate :name, :email, to: :student, prefix: true

  enum status: [:draft, :in_progress, :submitted, :approved, :rejected]

  scope :published, ->{ where.not(status: 'draft') }

  before_validation :set_short_description

  validates :due_at, presence: true, if: :published?
  validates :title, :description, :short_description, presence: true
  validates :title, :description, :short_description, length: {minimum: 10}, allow_blank: true
  validates :short_description, length: {maximum: 30}, allow_blank: true

  def published?
    !draft?
  end

  def completion_percentage
    (completion_rate * 100).round
  end

  private

  def set_short_description
    self.short_description = self.description.to_s[0...30] unless short_description.present?
  end
end
