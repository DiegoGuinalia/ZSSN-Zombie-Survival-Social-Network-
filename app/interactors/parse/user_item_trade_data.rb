module Parse
  class UserItemTradeData
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      validate
      parse_data
    end
  
    private
  
    def validate
      result = UserItemTradeContract.new.call(params.to_unsafe_h)
      context.fail!(error: result.errors.to_h) unless result.success?
    end
  
    def parse_data
      user_item_trade_context
    end

    def user_item_trade_context
      context.proposer_user = params[:proposer_user]
      context.accepting_user = params[:accepting_user]
    end
  end
end
