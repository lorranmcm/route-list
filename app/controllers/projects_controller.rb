class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit, :update, :destroy]

  def index
    if params[:query].present?
      @projects = policy_scope(Project).search_by_title(params[:query])
    else
      @projects = policy_scope(Project).order(created_at: :desc)
    end
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @user = current_user
    @project.user = @user
    authorize @project
    @project.save
    redirect_to projects_path
  end

  def update
    @project.update(project_params)
    respond_to do |format|
      authorize @project
      if @project.save
        format.html { redirect_to projects_path(@project) }
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render 'projects/show' }
        format.json # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  def destroy
    @project.destroy
    authorize @project
    redirect_to projects_path
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
