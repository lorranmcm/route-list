class AddTaskToTaskGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :task_groups, :task, null: false, foreign_key: true
  end
end
