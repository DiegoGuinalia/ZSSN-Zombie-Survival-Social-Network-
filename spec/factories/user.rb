# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    name { Faker::Name.name }
    age { Faker::Number.decimal_part(digits: 2) }
    gender { Faker::Gender.binary_type }
  end
end
