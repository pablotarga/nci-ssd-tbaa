class AddDueAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :due_at, :date
  end
end
