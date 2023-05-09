class Api::V1::UsersController < ApplicationController
  def create
    result = PlaceUsers.call(params: params)

    body(result)
  end

  def update_user_items
    result = PlaceUserItems.call(params: params)

    body(result)
  end

  def delete_user_items
    result = Delete::UserItems.call(params: params)

    body(result)
  end

  def mark_as_infected
    result = Update::InfectedUser.call(params: params)

    body(result)
  end

  def trade_user_items
    result = PlaceUserItemTrades.call(params: params)

    body(result)
  end
end
