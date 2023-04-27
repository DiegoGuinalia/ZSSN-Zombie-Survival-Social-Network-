# frozen_string_literal: true

class UserItemParser
  def initialize(params)
    @items = params
  end

  def run
    items_parse = []
    @items.map do |item|

      items_parse << {
        name: item[:name],
        quantity: item[:quantity]
      }
    end.flatten.uniq
  end
end
