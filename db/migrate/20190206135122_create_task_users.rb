class CreateTaskUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :task_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true

      t.timestamps
    end
  end
end
