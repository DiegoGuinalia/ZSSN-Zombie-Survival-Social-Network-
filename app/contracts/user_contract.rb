# frozen_string_literal: true

class UserContract < Dry::Validation::Contract
  params do
    optional(:user_id).value(:integer)
    required(:name).value(:string)
    required(:age).value(:integer)
    required(:gender).value(:string)

    required(:position).hash do
      required(:lat).value(:string)
      required(:long).value(:string)
    end
  end
end