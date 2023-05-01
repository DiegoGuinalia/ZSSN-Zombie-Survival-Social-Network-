module Utils
  def within_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      rescue => error
        @error = error
        puts @error
        raise ActiveRecord::Rollback
      end
    end
  end

  def user_exists?
    has_user = ::User.where(id: params[:user_id]).exists?
    context.fail!(error: "user doesn't exist") unless has_user
  end

  def user
    User.find_by(id: params[:user_id])
  end

  def user_items
    user.user_items
  end

  def infected_user?
    context.fail!(error: "user is infected") if user.infected
  end
end