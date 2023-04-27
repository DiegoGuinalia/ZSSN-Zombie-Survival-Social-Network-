module Parse
  class UserData
    include Interactor

    delegate :params, to: :context

    def call
      validate
      parse_data
    end
  
    private
  
    def validate
      result = UserContract.new.call(params.to_unsafe_h)
      context.fail!(error: result.errors.to_h) unless result.success?
    end
  
    def parse_data
      user_context
      position_context
    end

    def user_context
      user_parser = UserParser.new(context.params)
      context.user_data = user_parser.run
    end

    def position_context
      position_parser = PositionParser.new(context.params[:position])
      context.position_data = position_parser.run
    end
  end
end 
