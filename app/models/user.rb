class User < ApplicationRecord
  has_many :user_items
  has_one :user_position
end
