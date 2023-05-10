class Api::V1::ReportsController < ApplicationController
  def infected_percentage
    result = Reports::InfectedUsers.call

    body(result, result.infected_users_percentage)
  end

  def not_infected_percentage
    result = Reports::NotInfectedUsers.call

    body(result, result.infected_users_percentage)
  end

  def lost_points
    result = Reports::LostPoints.call

    body(result, result.lost_points)
  end

  def average_items_per_user
    result = Reports::AverageItemsPerUser.call

    body(result, result.average_items_per_user)
  end
end
