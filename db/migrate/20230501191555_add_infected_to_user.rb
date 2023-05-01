class AddInfectedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :infected, :boolean
  end
end
