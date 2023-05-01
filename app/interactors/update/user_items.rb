module Update
  class UserItems
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      infected_user?
      within_transaction do
        create_or_update_items
      end
    end
  
    private

    def create_or_update_items
      context.user_item_data.map do |context_item|
        item = Item.find_by(name: context_item[:name])
        user_item = find_user_item(user, item)

        if has_not_user_items(user_items) || !user_item
          create_item(user, item, context_item)
        else
          user_item.update(quantity: context_item[:quantity])
          context.user_items = user_items
        end
      end
    end

    def create_item(user, item, context_item)
      context.user_items = ::UserItem.create(
        user: user,
        item: item,
        quantity: context_item[:quantity]
      )
    end
  end
end
