class TasksController < ApplicationController
  before_action :set_project

  def index
    @tasks = Task.all
    @tasks = policy_scope(Task).order(created_at: :desc)
    @markers = @tasks.geocoded.map do |task|
      {
        project_id: @project.id,
        task_project_id: task.project.id,
        task_id: task.id,
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
      format.html { render partial: 'show.html', locals: { project: @project, task: @task } }
      format.text { render partial: 'show.html', locals: { project: @project, task: @task } }
    end
  end

  def new
    @task = Task.new
    authorize @task

    respond_to do |format|
      format.html { render partial: 'create.html', locals: { project: @project } }
      format.text { render partial: 'create.html', locals: { project: @project } }
    end
  end

  def create
    @task = Task.new(task_params)
    @task.project = @project
    @task.status = false
    # if @project.tasks.count != 0
    #   @task.order = @project.tasks.sort_by(&:order).last.order+1
    # else
    #   @task.order = 1
    # end
    @chatroom = Chatroom.new(chatroom: @task.title)
    @chatroom.save

    authorize @task

    # @project.tasks.each do |t|
    #   if t != @task && t.order <= @task.order
    #     t.order -= 1
    #     t.save!
    #   end
    # end
    @task.save

    respond_to do |format|
      format.json { redirect_to project_tasks_path(@project) }
      format.html { redirect_to project_tasks_path(@project) }
      format.text { redirect_to project_tasks_path(@project) }
    end
  end

  def complete!
    @task = Task.find(params[:id])
    @task.status = true
    @task.save!
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
    if current_user.team == 'manager'
      @task.update(manager_task_params)
    else
      @task.update(employee_task_params)
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    authorize @task
    redirect_to project_tasks_path(@project)
  end

  private

  def manager_task_params
    params.require(:task).permit(:description, :title, :address)
  end

  def employee_task_params
    params.require(:task).permit(:status)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :title, :address)
  end
end
