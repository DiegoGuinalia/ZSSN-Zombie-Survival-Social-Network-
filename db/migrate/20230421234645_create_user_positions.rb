class CreateUserPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_positions do |t|
      t.string :lat
      t.string :Long
      t.integer :user_id

      t.timestamps
    end
  end
end
