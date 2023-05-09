# frozen_string_literal: true

class UserItemTradeContract < Dry::Validation::Contract
  params do
    required(:proposer_user).hash do
      required(:id).value(:integer)

      required(:items).array(:hash) do
        required(:name).value(:string)
        required(:quantity).value(:string)
      end
    end

    required(:accepting_user).hash do
      required(:id).value(:integer)

      required(:items).array(:hash) do
        required(:name).value(:string)
        required(:quantity).value(:string)
      end
    end
  end

  rule('proposer_user.items') do
    values[:proposer_user][:items].each_with_index do |item, idx|
      if !Item.accepted_items.keys.include?(item[:name].to_sym)
        key([:items, idx]).failure('item not accepted')
      end

      if !/^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/.match?(item[:quantity])
        key([:items, idx]).failure('only numeric value is permited')
      end
    end
  end

  rule('accepting_user.items') do
    values[:accepting_user][:items].each_with_index do |item, idx|
      if !Item.accepted_items.keys.include?(item[:name].to_sym)
        key([:items, idx]).failure('item not accepted')
      end

      if !/^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/.match?(item[:quantity])
        key([:items, idx]).failure('only numeric value is permited')
      end
    end
  end
end
