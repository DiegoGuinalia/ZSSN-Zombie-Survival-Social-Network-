module Reports
  class InfectedUsers
    include Interactor
    include Reports::Utils::Percentage

    def call
      context.infected_users_percentage = {
        "infected_users" => "#{get_infected_percentage_number}% of users are infected"
      }
    end
  end
end
