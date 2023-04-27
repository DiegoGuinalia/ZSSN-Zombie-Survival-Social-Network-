module Utils
  def within_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      rescue => error
        @error = error
        raise ActiveRecord::Rollback
      end
    end
  end
end