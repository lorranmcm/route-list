class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @tasks = policy_scope(Task).order(created_at: :desc)
  end

  def create
    @project = Project.find(params[:project_id])
    Task.where(project: @project)
    @task = Task.new
    authorize @task
    @task.user = current_user
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
