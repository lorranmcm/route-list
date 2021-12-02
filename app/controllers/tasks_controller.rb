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
      format.text { render partial: 'show.html', locals: { project: @project, task: @task } }
    end
  end

  def createform
    @task = Task.new
    respond_to do |format|
      format.html { render partial: 'create.html', locals: { project: @project } }
      format.text { render partial: 'create.html', locals: { project: @project } }
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @task = Task.new
    @task.user_id = current_user.id
    @task.project = @project
    @task.status = false
    authorize @task

    @project.tasks.each do |t|
      if t != @task && t.order <= @task.order
        t.order -= 1
        t.save!
      end
      @task.save

    respond_to do |format|
      format.json { render partial: 'show.html', locals: { project: @project, task: @task } }
      format.html { render partial: 'show.html', locals: { project: @project, task: @task } } # Follow regular flow of Rails
      format.text { render partial: 'show.html', locals: { project: @project, task: @task } }
    end
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
