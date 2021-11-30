class RenameTaskGroupsToProjects < ActiveRecord::Migration[6.0]
  def change
    rename_table :task_groups, :projects
  end
end
