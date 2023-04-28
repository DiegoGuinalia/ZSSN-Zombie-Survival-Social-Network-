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

      user_items.where(item_id: item_ids).destroy_all
    end

    def user
      User.find_by(id: params[:user_id])
    end

    def user_items
      user.user_items
    end

    def item_ids
      user_items.map{|ui| ui.item_id if params[:items].include?(ui.item.name)}.compact
    end
  end
end
