# frozen_string_literal: true

class PositionParser
  def initialize(params)
    @params = params
  end

  def run
    {
      lat: @params[:lat],
      long: @params[:long]
    }
  end
end
