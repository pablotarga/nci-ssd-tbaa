class Task
  class StatusService

    attr_reader :user, :transitions
    def initialize(user:)
      @user = user
      build_transitions
    end

    def possible_transitions_for(task)
      list = transitions[task.status] rescue nil
      list.presence || []
    end

    def status_available?(task, status)
      possible_transitions_for(task).include?(status)
    end

    def change(task, status)
      return false unless status_available?(task, status)
      return false unless task.send("#{status}!")

      # notify that task has changed
      Project::CompletionService.new(task.project).calculate!
    end

    private

    def build_transitions
      @transitions = {}

      Task.statuses.keys.each do |status|
        list = []
        list += %w[rejected completed] if user.advisor?

        case status
        when 'pending'
          list += %w[in_progress review done]
        when 'review'
          list += %w[in_progress done]
        when 'in_progress'
          list += %w[review done]
        when 'done'
          list += %w[in_progress review]
        when 'rejected'
          list -= %w[rejected] # remove rejected status if task is rejected
        when 'completed'
          list -= %w[completed] # remove completed status if task is completed
        end

        transitions[status] = list
      end
    end
  end
end
