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
      project.update_attribute :completion_rate, rate
    end
  end
end
