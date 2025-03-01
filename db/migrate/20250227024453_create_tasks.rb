class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks, id: :uuid do |t|
      t.text :body, null: false
      t.integer :user_id, null: false, index: true
      t.datetime :last_synchronization

      t.timestamps
    end

    add_foreign_key :tasks, :users
  end
end
