module Schedulable
  extend ActiveSupport::Concern
  included do
    validate :ensure_due_at_is_future, if: :due_at_changed?
  end

  private

  def ensure_due_at_is_future
    errors.add :due_at, 'must be in the future' if due_at && due_at.past?
  end

end
