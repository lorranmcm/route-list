class ProjectsController < ApplicationController
  before_action :set_project
  def index
    @projects = Project.all
    @projects = policy_scope(Project).order(created_at: :desc)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
