class CreateTaskGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :task_groups do |t|
      t.string :title

      t.timestamps
    end
  end
end
