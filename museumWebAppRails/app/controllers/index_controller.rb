class IndexController < ApplicationController

  def logs


    #@logs = "some logs"
    #@logs = `tail -n 5 /home/gabe/Desktop/capstone2/museum_monitoring_sensors/museumWebAppRails/log/moteinoAndPi.log`.split("\n")


    #file = Rails.root + "/log/moteinoAndPi.log"
    file = File.join(Rails.root, 'log','moteinoAndPi.log')
  #  lines = File.open(file).to_a
    lines = IO.readlines(file)
    linesLength = lines.length

    if linesLength >= 5
      @logs = lines[linesLength-5], lines[linesLength-4], lines[linesLength-3], lines[linesLength-2], lines[linesLength-1]
    elsif linesLength != 0
      #@logs = lines[linesLength-5], lines[linesLength-4], lines[linesLength-3], lines[linesLength-2], lines[linesLength-1]
      @logs = lines
    end

    end
end
