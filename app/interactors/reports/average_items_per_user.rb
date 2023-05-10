module Reports
  class AverageItemsPerUser
    include Interactor

    def call
      average_items_per_user
    end

    private

    def average_items_per_user
      averages = {}
      items = UserItem.joins(:item).pluck('items.name, user_items.quantity, user_items.user_id')
  
      
      items.each do |item|
        name = item[0]
        quantity = item[1].to_f
  
        if averages[name].nil?
          averages[name] = { total_quantity: quantity, num_users: User.count }
        else
          averages[name][:total_quantity] += quantity
        end
        averages[name][:num_users] == User.count
      end
      
      context.average_items_per_user = averages.map do |name, value|
        average_quantity = (value[:total_quantity] / value[:num_users]).round(2)
          {"#{name}": "On average, each user has #{average_quantity} #{name}"}
      end
    end  
  end
end
