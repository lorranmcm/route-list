class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @projects = policy_scope(Project).order(created_at: :desc)
  end

end
