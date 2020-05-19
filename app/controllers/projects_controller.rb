class ProjectsController < RestrictAccessController
  # call memoized method project (load variable to be used on the actions/views) and send to index if project is not found
  before_action :require_project, only: [:show, :edit, :update, :destroy]

  # any other action apart from list and show are only available to advisors
  before_action :must_be_advisor, except: [:index, :show]

  # use method from application controller to unpack params from the url and populate record with info
  before_action :load_prev_params, only: [:edit, :new]

  # list projects, will filter accordingly the current user role
  def index
    @list = query_scope
  end

  # initialize a new object to build the the form
  def new
    @project = current_user.projects.new
  end

  # action to load the edit form, nothing if called because before_actions are loading and preparing the record
  # require_project and load_prev_params
  def edit
  end

  # action called after the submission of form rendered on action :new (project not persisted, or in other words id.nil?)
  def create
    # As action is only available for advisors (before_action :must_be_advisor) we are 100% sure current user is an advisor
    project = current_user.projects.new(project_params)

    # try to save the project with submitted params
    if project.save
      # if saved call a service to calculate the progress of the project, this service will be called in other actions
      Project::CompletionService.new(project).calculate!

      # redirect to list of projects with success message on the flash[:notice]
      redirect_to(projects_path, notice: 'Project created with success!')
    else
      # if not successful the object will be full of errors and we can use this to build the form and style the fields
      redirect_to(new_project_path(**pack_params(project_params)), alert: project.errors.full_messages)
    end
  end

  # actino called after the submission of form rendered on action :edit (persisted project)
  def update
    # from the loaded project (memoized method) try to apply params
    if project.update_attributes(project_params)
      # if saved call a service to calculate the progress of the project, this service will be called in other actions
      Project::CompletionService.new(project).calculate!

      # redirect with success message
      redirect_to(projects_path, notice: 'Project updated with success!')
    else
      # redirect with error message
      redirect_to(edit_project_path(project, **pack_params(project_params)), alert: project.errors.full_messages)
    end
  end

  def destroy
    # remove project from the database
    if project.destroy
      redirect_to(projects_path, notice: 'Project removed with success!')
    else
      redirect_to(projects_path, alert: 'Project cannot be removed at this time, try again later')
    end
  end

  private

  def status_service
    @status_service ||= Task::StatusService.new(user: current_user)
  end
  helper_method :status_service

  # extract base64 params from the query params
  def load_prev_params
    prev_params = unpack_params
    if prev_params.present?
      project.attributes = prev_params
      project.valid?
    end
  end

  # check which relation will retrieve from current_user
  def query_scope
    current_user.advisor? ? current_user.projects : current_user.submissions
  end

  # try to load the project from the query_scope + plus route param :id
  def project
    @project ||= query_scope.find_by(id: params[:id])
  end

  # helper method makes this method available on the views, so project can be accessed through method project instead directly from the variable (getter wrapper)
  helper_method :project

  # extract required and permited params (strong parameters)
  def project_params
    # memoization to avoid re-extract params, convert into hash and symbolize keys
    @project_params ||= extract_params :project, permit: [
      :title,
      :short_description,
      :description,
      :student_id,
      :due_at,
      :status,
      tasks_attributes: [:id, :title, :status, :priority, :due_at, :_destroy]
    ]
  end

  def must_be_advisor
    redirect_to(projects_path, alert: 'You must be advisor to access this page') unless current_user.advisor?
  end

  def require_project
    redirect_to(projects_path, alert: 'Project not found') unless project.present?
  end


end
