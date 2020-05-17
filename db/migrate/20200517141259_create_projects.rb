class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :advisor
      t.references :student
      t.integer :status, null: false, default: 0
      t.decimal :completion_rate, null: false, default: 0
      t.date :due_at
      t.string :title
      t.text :description
      t.text :short_description

      t.index :status
      t.index :due_at

      t.timestamps
    end
  end
end
