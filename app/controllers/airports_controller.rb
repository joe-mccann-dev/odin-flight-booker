class AirportsController < ApplicationController
  def create
    @airport = Airport.new(airport_params)
    @airport.save
  end

  def airport_params
    params.require(:airport).permit(:code)
  end
end
