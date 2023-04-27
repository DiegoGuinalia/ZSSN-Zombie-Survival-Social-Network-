class Item < ApplicationRecord
  ACCEPTED_NAMES = %w(water food medicine ammunition)
  
  ACCEPTED_ITEMS = {
    water:	4,
    food:	3,
    medicine:	2,
    ammunition:	1
  }

  validates :name,
    :presence => true,
    :uniqueness => {:scope => :name},
    :inclusion => {:in => ACCEPTED_NAMES}

  def self.accepted_items
    ACCEPTED_ITEMS
  end
end
