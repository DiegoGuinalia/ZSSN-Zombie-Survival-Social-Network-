module Parse
  class UserItemData
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      validate
      parse_data
    end
  
    private
  
    def validate
      result = UserItemContract.new.call(params.to_unsafe_h)
      context.fail!(error: result.errors.to_h) unless result.success?
      user_exists?
    end
  
    def parse_data
      user_item_context
    end

    def user_item_context
      user_item_parser = UserItemParser.new(context.params[:items])
      context.user_item_data = user_item_parser.run
    end
  end
end 
