class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @projects = policy_scope(Project).order(created_at: :desc)
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

  private

  def project_params
    params.require(:project).permit(:title)
  end
end
