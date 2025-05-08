class RemoveTaskCountFromTodolists < ActiveRecord::Migration[8.0]
  def change
    remove_column :todolists, :task_count, :integer
  end
end
