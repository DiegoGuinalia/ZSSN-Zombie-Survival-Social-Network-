module Delete
  class UserItems
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      validate
      within_transaction do
        delete_user_items
      end
    end
  
    private

    def validate
      result = UserItemDeleteContract.new.call(params.to_unsafe_h)
      context.fail!(error: result.errors.to_h) unless result.success?
    end
  

    def delete_user_items
      item_ids

      user_items(user).where(item_id: item_ids).destroy_all
    end

    def item_ids
      user_items(user).map{|ui| ui.item_id if params[:items].include?(ui.item.name)}.compact
    end
  end
end
