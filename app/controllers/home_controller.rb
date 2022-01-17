class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    #Uniform Resource Locator (URL)
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=20002&distance=25&API_KEY=8EB9244E-5A4C-4CDD-9F36-EF22622E8600'

    #Uniform resource identifier
    @uri = URI(@url)

    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    #Error handling, check for empty result
    if @output.empty?
      @final_output = "Error"

      @api_colour = "gray"

      @description = 'Error'
    else 
      @final_output = @output[0]['AQI']

      # if @final_output = "Error"
      #   @api_colour = 'gray'
      if @final_output <= 50
        @api_colour = 'green'
        @description = 'Good'
      elsif @final_output >= 51 && @final_output <= 100
        @api_colour = 'yellow'
        @description = 'Moderate'
      elsif @final_output >= 101 && @final_output <= 150
        @api_colour = 'orange'
        @description = '(USG) Unhealthy for Sensitive Groups'
      elsif @final_output >= 151 && @final_output <= 200
        @api_colour = 'red'
        @description = 'Unhealthy'
      elsif @final_output >= 201 && @final_output <= 300
        @api_colour = 'purple'
        @description = 'Very Unhealthy'
      elsif @final_output >= 301 && @final_output <= 500
        @api_colour = 'maroon'
        @description = 'Hazardous'
      end
    end

  end
end
