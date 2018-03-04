class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :subject, :null => false
      t.integer :status, :null => false, :default => 0
      t.integer :priority, :null => false, :default => 0
      t.datetime :deadline, :null => false

      t.timestamps
    end
  end
end
