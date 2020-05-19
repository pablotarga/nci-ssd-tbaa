class Project
  class CompletionService < ApplicationService
    attr_reader :project
    def initialize(project)
      @project = project
    end

    def calculate!
      total = project.tasks.active.count.to_f
      done = project.tasks.finished.count.to_f

      rate = total == 0 ? 0 : (done / total)
      return false unless project.update_attribute :completion_rate, rate

      ActionCable.server.broadcast 'projects_channel', project.slice(:id, :completion_percentage)
      return true
    end
  end
end
