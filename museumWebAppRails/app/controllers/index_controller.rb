class IndexController < ApplicationController

  def logs


    #@logs = "some logs"
    #@logs = `tail -n 5 /home/gabe/Desktop/capstone2/museum_monitoring_sensors/museumWebAppRails/log/moteinoAndPi.log`.split("\n")


    #file = Rails.root + "/log/moteinoAndPi.log"
    file = File.join(Rails.root, 'log','moteinoAndPi.log')
  #  lines = File.open(file).to_a
    lines = IO.readlines(file)
    linesLength = lines.length
    # i = lineLength, while i > lineLength-5
      #append line to log, i--
  #  @logs = ""
    #  for i in (lineLength).downto(lineLength-5)
    #    @logs = @logs + IO.readlines(file)[i]
    #  end
    @logs = lines[linesLength-5], lines[linesLength-4], lines[linesLength-3], lines[linesLength-2], lines[linesLength-1]
    end
end
