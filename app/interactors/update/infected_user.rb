module Update
  class InfectedUser
    include Interactor
    include Utils

    delegate :params, to: :context

    def call
      validate
      within_transaction do
        create_infected_user_history
        mark_as_infected
      end
    end
  
    private

    def validate
      result = InfectedUserContract.new.call(params.to_unsafe_h)
      context.fail!(error: result.errors.to_h) unless result.success?
    end

    def create_infected_user_history
      InfectedUser.create(user_id: params[:user_id], informant_id: params[:informant_id])
    end

    def mark_as_infected
      if should_mark_as_infected?
        user.update(infected: true)
      end
    end

    def should_mark_as_infected?
      InfectedUser.where(user_id: params[:user_id]).size >= 2
    end
  end
end
