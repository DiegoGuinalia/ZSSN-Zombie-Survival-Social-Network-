class PlaceUserItems
  include Interactor::Organizer

  organize Parse::UserItemData, Update::UserItems
end
