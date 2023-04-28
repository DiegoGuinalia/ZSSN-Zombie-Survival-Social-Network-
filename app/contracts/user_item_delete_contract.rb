# frozen_string_literal: true

class UserItemDeleteContract < Dry::Validation::Contract
  params do
    required(:user_id).value(:integer)
    required(:items).array(:string)
  end
end