class AssignmentsController < ApplicationController
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save
    authorize @assignment
  end

  private

  def assignment_params
    params.require(:assignment).permit(:user, :task)
  end
end
