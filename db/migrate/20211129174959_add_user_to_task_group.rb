class AddUserToTaskGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :task_groups, :user, null: false, foreign_key: true
  end
end
