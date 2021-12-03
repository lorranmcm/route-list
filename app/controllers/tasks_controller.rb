class TasksController < ApplicationController
  before_action :set_project

  def index
    @tasks = Task.all
    @tasks = policy_scope(Task).order(created_at: :desc)
    @markers = @tasks.geocoded.map do |task|
      {
        lat: task.latitude,
        lng: task.longitude,
        info_window: render_to_string(partial: "info_window", locals: { task: task })
      }
    end
  end

  def show
    @task = Task.find(params[:id]) #check future route
    @task.description

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'show.html', locals: { project: @project, task: @task } }
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new
    # authorize @task
    @task.user_id = current_user.id
    @task.project = @project
    @task.status = false
    @task.description = params[:description]
    @task.address = params[:address]
    @task.order = params[:order]

    @project.tasks.each do |t|
      if t != @task && t.order <= @task.order
        t.order -= 1
        t.save!
      end
      @task.save
    end
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
    @task.update(task_params)
    respond_to do |format|
    format.json { render partial: 'show.html', locals: { project: @project, task: @task } }
    format.html { render partial: 'show.html', locals: { project: @project, task: @task } } # Follow regular flow of Rails
    format.text { render partial: 'show.html', locals: { project: @project, task: @task } }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :address)
  end
end
