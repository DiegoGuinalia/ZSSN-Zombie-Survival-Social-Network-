# frozen_string_literal: true

class InfectedUserContract < Dry::Validation::Contract
  params do
    optional(:user_id).value(:integer)
    optional(:informant_id).value(:integer)
  end

  rule('informant_id') do
    if !values[:user_id]
      key(:user_id).failure('user_id should be present to report an infected user') 
    end
  end

  rule('informant_id') do
    if !value
      key(:informant_id).failure('informant_id should be present to report an infected user') 
    end
  end


  rule('informant_id') do
    if value == !values[:informant_id]
      key(:informant_id).failure('informant_id must be different from user_id') 
    end
  end


  rule('informant_id') do
    if InfectedUser.where(user_id: values[:user_id], informant_id: values[:informant_id]).exists?
      key(:informant_id).failure('informant_id has already report this user') 
    end
  end
end