class TasksController < RestrictAccessController
  before_action :require_task, only: :update

  def index
    # includes will return the projects in a efficient manner, avoiding N+1 queries
    @list = current_user.tasks.includes(:project).order(:due_at, :status)
  end

  def update
    status_service = Task::StatusService.new(user: current_user)
    path = project.present? ? project_path(project) : tasks_path

    respond_to do |format|
      if status_service.change(task, params[:status])
        format.html{ redirect_to path, notice: 'Task updated successfully' }
        format.js
      else
        format.html{ redirect_to path, alert: 'Oops something went wrong! Try again later' }
        format.js
      end
    end
  end

  private

  def status_service
    @status_service ||= Task::StatusService.new(user: current_user)
  end
  helper_method :status_service

  def task
    # scoping only tasks visible to current user
    @task ||= current_user.tasks.find_by(id: params[:id])
  end

  def project
    @project ||= Project.find_by(id: params[:project_id]) if params[:project_id].present?
  end
  helper_method :project

  def require_task
    redirect_to(tasks_path, alert: 'Task not found') unless task.present?
  end
end
