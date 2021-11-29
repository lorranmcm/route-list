class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :address
      t.integer :order
      t.boolean :status

      t.timestamps
    end
  end
end
