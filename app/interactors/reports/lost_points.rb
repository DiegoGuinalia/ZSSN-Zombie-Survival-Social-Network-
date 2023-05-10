module Reports
  class LostPoints
    include Interactor

    def call
      context.lost_points = {
        "lost_points" => "#{User.points_lost_by_infected_users} user points are lost by infected users"
      }
    end
  end
end
