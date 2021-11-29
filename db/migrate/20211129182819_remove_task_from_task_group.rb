class RemoveTaskFromTaskGroup < ActiveRecord::Migration[6.0]
  def change
    remove_reference :task_groups, :task, null: false, foreign_key: true
  end
end
