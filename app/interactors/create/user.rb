module Create
  class User
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      within_transaction do
        create_user
        create_position
      end
    end
  
    private

    def create_user
      user = ::User.find_by(id: params[:user_id])
      if user.nil?
        return context.user = ::User.create(
          context.user_data
        )
      end

      user.update(context.user_data)
      context.user = user
    end

    def create_position
      user_position = context.user.user_position
      context.position_data = context.position_data.merge!(user_id: context.user.id)

      if user_position.nil?
        context.user_position = ::UserPosition.new(context.position_data)
        return context.user_position.save 
      end

      user_position.update(context.position_data)
      context.user_position = user_position
    end
  end
end
