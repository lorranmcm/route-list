class TasksController < ApplicationController
  before_action :set_project
  def index
    @tasks = Task.all
    @tasks = policy_scope(Task).order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id]) ##check future route
    @task.description

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'show.html', locals: { task: @task } }
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
    @task.update(task_params)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
