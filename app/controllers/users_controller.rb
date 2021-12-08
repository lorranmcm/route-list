class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    if params[:user_query].present?
      @users = policy_scope(User).search_by_name(params[:user_query])
      @tasks = policy_scope(Task).order(created_at: :desc)
    elsif params[:task_query].present?
      @tasks = policy_scope(Task).search_by_title(params[:task_query])
      @users = policy_scope(Task).order(created_at: :desc)
    else
      @users = policy_scope(User).order(created_at: :desc)
      @tasks = policy_scope(Task).order(created_at: :desc)
    end
    @assignment = Assignment.new
  end

  def show
    @user = User.find(params[:id]) #check future route
    @user.first_name
    @user.last_name

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'show.html', locals: { user: @user } }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
  #def new
  #  @user = user.new
  #  authorize @user

  #  respond_to do |format|
  #    format.html { render partial: 'create.html', locals: { project: @project } }
  #    format.text { render partial: 'create.html', locals: { project: @project } }
  #  end
  # end

  # def create
  #  @user = user.new(user_params)
  #  @user.project = @project
  #  @user.status = false
  #  # if @project.users.count != 0
  #  #   @user.order = @project.users.sort_by(&:order).last.order+1
  #  # else
  #  #   @user.order = 1
  #  # end

  #  authorize @user

  #  # @project.users.each do |t|
  #  #   if t != @user && t.order <= @user.order
  #  #     t.order -= 1
  #  #     t.save!
  #  #   end
  #  # end
  # @user.save

  #  respond_to do |format|
  #    format.json { redirect_to project_users_path(@project) }
  #    format.html { redirect_to project_users_path(@project) }
  #    format.text { redirect_to project_users_path(@project) }
  #  end
  # end

  # def complete!
  #   @user = user.find(params[:id])
  #   @user.status = true
  #   @user.save!
  # end

  # def update
  #   @user = user.find(params[:id])
  #   authorize @user
  #   @user.update(user_params)
  # end

# def destroy
#   @user.destroy
#   authorize @trask
#   redirect_to project_user_path
# end

# private

# def set_project
#   @project = Project.find(params[:project_id])
# end

# def user_params
# params.require(:user).permit(:description, :title, :address)
#   end
