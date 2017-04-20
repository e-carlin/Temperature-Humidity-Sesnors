class IndexController < ApplicationController
  include ActionView::Helpers::TextHelper
  #Added to make sure that only logged in users can access our site
  #before_action :require_login
  def logs
    #@logs = "some logs"
    #@logs = `tail -n 5 /home/gabe/Desktop/capstone2/museum_monitoring_sensors/museumWebAppRails/log/moteinoAndPi.log`.split("\n")

    #file = Rails.root + "/log/moteinoAndPi.log"
    file = File.join(Rails.root, 'log','moteinoAndPi.log')
    if !File.file?('moteinoAndPi.log')
      File.new(file, "a")
    end
  #  lines = File.open(file).to_a
    lines = IO.readlines(file)
    linesLength = lines.length
    @logs = ""
    if linesLength >= 5
      for i in linesLength-5..linesLength-1
        #@logs << lines[i].gsub("\n", "")
        @logs << lines[i]
      end
    elsif linesLength != 0
      #@logs = lines[linesLength-5], lines[linesLength-4], lines[linesLength-3], lines[linesLength-2], lines[linesLength-1]
      for i in 0..linesLength-1
        @logs << lines[i]
      end
    #  @logs = lines
    end

    end

    #Displays the home page information
    def index
        @avgtmp = Reading.average(:temperature)
        @totalSensors = Node.where(last_reading: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)).count(:all)

        #@totalSensors = Node.where(last_reading: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count(:all)

        
        if Reading.last.nil?
          @lastTemp = "NA"
        else
          @lastTemp = Reading.last.temperature
        end

        if Reading.last.nil?
          @lastHum = "NA"
        else
         @lastHum = Reading.last.humidity
       end
        @totalReadings = Reading.count(:all)
    end

  
end
