# frozen_string_literal: true

class UserParser
  def initialize(params)
    @params = params
  end

  def run
   {
      name: @params[:name],
      age: @params[:age],
      gender: @params[:gender]
    }
  end
end
