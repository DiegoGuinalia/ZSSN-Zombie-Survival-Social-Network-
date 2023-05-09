module Trade
  class UserItems
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      if enable_to_trade
        return within_transaction do
          handle_items(context[:accepting_user], context[:proposer_user][:items])
          handle_items(context[:proposer_user], context[:accepting_user][:items])
        end
      end

      context.fail!(error: "item doesn't exist/invalid quantity") 
    end

    private

    def handle_items(user_data, items_context)
      user = user(user_data[:id])
      user_items = user_items(user)
      context.fail!(error: "user is infected") if user.infected
      items_context.each do |user_item_context|
        user_item = user_items.find_by(item_id: user_item_context[:item_id])
        next if !user_item

        if (user_item.quantity.to_f - user_item_context[:quantity].to_f).zero?
          user_item.destroy
        else
          user_item.update(quantity: user_item.quantity.to_f - user_item_context[:quantity].to_f)
        end

        partner_items = partner_items(user)
        partner_user_item = partner_items.find_by(item_id: user_item_context[:item_id])

        if partner_user_item
          partner_user_item.update(quantity: partner_user_item.quantity.to_f + user_item_context[:quantity].to_f)
        else
          UserItem.create(
            user_id: user.id,
            item_id: user_item_context[:item_id],
            quantity: user_item_context[:quantity]
          )
        end
      end
    end

    def user_items(user)
      user.user_items
    end

    def partner_items(user)
      UserItem.where(user_id: user.id == context[:accepting_user][:id] ? context[:proposer_user][:id] : context[:accepting_user][:id])
    end

    def enable_to_trade
      proposer_user_transaction_points == accepting_user_transaction_points
    end

    def proposer_user_transaction_points
      count_points(context[:proposer_user][:items])
    end

    def accepting_user_transaction_points
      count_points(context[:accepting_user][:items])
    end

    def count_points(items)
      items&.sum do |item|
        Item.accepted_items[item[:name].to_sym] * item[:quantity].to_f 
      end
    end
  end
end