class Api::V1::UsersController < ApplicationController
  def create
    result = PlaceUsers.call(params: params)

    body(result)
  end
end