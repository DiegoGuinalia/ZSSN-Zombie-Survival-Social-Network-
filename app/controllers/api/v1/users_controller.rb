class Api::V1::UsersController < ApplicationController
  def create
    result = PlaceUsers.call(params: params)

    body(result)
  end

  def update_user_items
    result = PlaceUserItems.call(params: params)

    body(result)
  end
end