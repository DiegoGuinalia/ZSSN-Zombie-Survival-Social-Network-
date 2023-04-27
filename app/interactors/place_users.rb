class PlaceUsers
  include Interactor::Organizer

  organize Parse::UserData, Create::User
end
