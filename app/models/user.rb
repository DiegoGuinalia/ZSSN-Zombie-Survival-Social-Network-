class User < ApplicationRecord
  has_many :user_items
  has_one :user_position
 
  def self.points_lost_by_infected_users
    users = self.where(infected: true)
    total_lost_points = 0
    
    users.each do |user|
      lost_points = user.user_items.sum do |user_item|
        item_value = Item.accepted_items[user_item.item.name.to_sym]
        item_value.to_f * user_item.quantity.to_f
      end
      
      total_lost_points += lost_points
    end
    
    return total_lost_points
  end

  
end
