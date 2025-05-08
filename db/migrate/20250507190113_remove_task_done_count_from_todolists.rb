class RemoveTaskDoneCountFromTodolists < ActiveRecord::Migration[8.0]
  def change
    remove_column :todolists, :task_done_count, :integer
  end
end
