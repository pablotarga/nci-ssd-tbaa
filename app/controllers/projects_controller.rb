class ProjectsController < RestrictAccessController
  before_action :require_project, only: [:show, :edit, :update, :destroy]
  before_action :must_be_advisor, except: [:index, :show]

  def index
    @list = query_scope
  end

  def new
    @project = current_user.projects.new

    if flash[:project_params].present?
      @project.attributes = flash[:project_params]
      @project.valid?
    end
  end

  def edit
    if flash[:project_params].present?
      project.attributes = flash[:project_params]
      project.valid?
    end
  end

  def create
    project = current_user.projects.new(project_params)

    if project.save
      redirect_to(projects_path, notice: 'Project created with success!')
    else
      flash[:project_params] = project_params
      redirect_to(new_project_path, alert: project.errors.full_messages)
    end
  end

  def update
    if project.update_attributes(project_params)
      redirect_to(projects_path, notice: 'Project updated with success!')
    else
      flash[:project_params] = project_params
      redirect_to(edit_project_path(project), alert: project.errors.full_messages)
    end
  end

  def destroy
    if project.destroy
      redirect_to(projects_path, notice: 'Project removed with success!')
    else
      redirect_to(projects_path, alert: 'Project cannot be removed at this time, try again later')
    end
  end

  private

  def query_scope
    current_user.advisor? ? current_user.projects : current_user.submissions
  end

  def project
    @project ||= query_scope.find_by(id: params[:id])
  end
  helper_method :project

  def project_params
    # memoization to avoid re-extract params, convert into hash and symbolize keys
    @project_params ||= extract_params :project, permit: [
      :title,
      :short_description,
      :description,
      :student_id,
      :due_at,
      :status,
    ]
  end

  def must_be_advisor
    redirect_to(projects_path, alert: 'You must be advisor to access this page') unless current_user.advisor?
  end

  def require_project
    redirect_to projects_path, alert: 'Project not found' unless project.present?
  end


end
