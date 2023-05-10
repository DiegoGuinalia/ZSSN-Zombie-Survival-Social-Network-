module Reports
  class NotInfectedUsers
    include Interactor
    include Reports::Utils::Percentage

    def call
      context.infected_users_percentage = {
        "not_infected_users" => "#{(100 - get_infected_percentage_number).round(2)}% of users are not infected"
      }
    end
  end
end
