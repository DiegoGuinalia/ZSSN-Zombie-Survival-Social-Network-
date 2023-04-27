# frozen_string_literal: true

class UserItemContract < Dry::Validation::Contract
  params do
    required(:user_id).value(:integer)

    required(:items).array(:hash) do
      required(:name).value(:string)
      required(:quantity).value(:string)
    end
  end

  rule('items') do
    values[:items].each_with_index do |item, idx|
      if !Item.accepted_items.keys.include?(item[:name].to_sym)
        key([:items, idx]).failure('item not accepted')
      end

      if !/^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/.match?(item[:quantity])
        key([:items, idx]).failure('only numeric value is permited')
      end
    end
  end
end