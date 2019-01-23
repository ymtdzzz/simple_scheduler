class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.datetime :start
      t.datetime :end
      t.text :memo
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tasks, [:user_id, :created_at]
    add_index :tasks, :start
    add_index :tasks, :end
  end
end
