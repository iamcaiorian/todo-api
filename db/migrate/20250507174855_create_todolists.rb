class CreateTodolists < ActiveRecord::Migration[8.0]
  def change
    create_table :todolists do |t|
      t.string :title
      t.string :subtitle
      t.string :color

      t.timestamps
    end
  end
end
