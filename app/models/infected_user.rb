class InfectedUser < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :informant, class_name: 'User'
end
