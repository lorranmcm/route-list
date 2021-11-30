class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @tasks = policy_scope(Task).order(created_at: :desc)
  end
end
