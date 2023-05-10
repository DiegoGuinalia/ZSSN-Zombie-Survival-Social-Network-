module Reports::Utils::Percentage
  def get_infected_percentage_number
    ((User.where(infected: true).count.to_f / ::User.count.to_f) * 100.0).round(2)
  end
end