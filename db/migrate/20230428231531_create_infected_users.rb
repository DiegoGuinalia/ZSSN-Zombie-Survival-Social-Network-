class CreateInfectedUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :infected_users do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :informant_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
