class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :project, foreign_key: true
      t.string :title, null: false
      t.integer :priority, null: false, default: 2
      t.integer :status, null: false, default: 0

      t.index :priority
      t.index :status

      t.timestamps
    end
  end
end
