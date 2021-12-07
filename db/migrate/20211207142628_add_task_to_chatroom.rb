class AddTaskToChatroom < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :task, null: false, foreign_key: true
  end
end
