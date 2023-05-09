class PlaceUserItemTrades
  include Interactor::Organizer

  organize Parse::UserItemTradeData, Trade::UserItems
end
