require 'sinatra/base'

require_relative "radar"

class FlightSchool < Sinatra::Base
  get "/" do
    erb :index, locals: { airports: ["JFK", "SFO", "OHR", "FWA", "OAK", "SEA", "LAX"] }
  end

  get "/airports/:code" do
    begin
      airport_status = Radar.status_for(params[:code])
      erb :airport, locals: { status: airport_status }
    rescue Radar::NoSuchAirport
      status 404
      erb :no_airport
    end
  end
end
