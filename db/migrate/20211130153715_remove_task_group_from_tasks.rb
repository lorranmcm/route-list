class RemoveTaskGroupFromTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :task_group_id
  end
end
