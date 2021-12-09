class TasksController < ApplicationController
  before_action :set_project

  def index
    @tasks = Task.includes(:chatroom)
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
    @chatroom = Chatroom.new(chatroom: @task.title)
    @chatroom.save
    @employees = User.all.select { |user| user.team == "employee" }
    @idle = @employees.min_by { |user| user.assignments.count }
    @assignment = Assignment.new(task_id: @task, user_id: @idle)

    # Take the user that has less assignment
    # when a task is created a new assignment is created between the task and the user that has less tasks

    # if @project.tasks.count != 0
    #   @task.order = @project.tasks.sort_by(&:order).last.order+1
    # else
    #   @task.order = 1
    # end

    authorize @task
    @task.save

    @chatroom = Chatroom.new(chatroom: @task.title, task: @task)
    @chatroom.save

    # @project.tasks.each do |t|
    #   if t != @task && t.order <= @task.order
    #     t.order -= 1
    #     t.save!
    #   end
    # end

    respond_to do |format|
      format.json { redirect_to project_tasks_path(@project) }
      format.html { redirect_to project_tasks_path(@project) }
      format.text { redirect_to project_tasks_path(@project) }
    end
  end

  def mark_as_done
    @task = Task.find(params[:id])
    @task.status = @task.status ? false : true
    authorize @task
    if @task.save!
      redirect_to project_tasks_path(@project)
    else
      render :show
    end
  end

  def update
    @task = Task.find(params[:id])
    @beforetitle = @task.title
    authorize @task
    if current_user.team == 'manager'
      @task.update(manager_task_params)
    else
      @task.update(employee_task_params)
    end
    if @task.status == false || @beforetitle != @task.title
      redirect_to project_tasks_path(@project)
    end
  end

  def complete
    @task = Task.find(params[:id])
    authorize @task
    @task.status = false
    @task.save
    redirect_to project_tasks_path(@project)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    authorize @task
    redirect_to project_tasks_path(@project)
  end

  private

  def manager_task_params
    params.require(:task).permit(:description, :title, :address, :status)
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
