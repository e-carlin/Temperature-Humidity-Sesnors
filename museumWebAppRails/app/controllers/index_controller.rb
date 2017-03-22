class IndexController < ApplicationController
  include ActionView::Helpers::TextHelper

  def logs
    #@logs = "some logs"
    #@logs = `tail -n 5 /home/gabe/Desktop/capstone2/museum_monitoring_sensors/museumWebAppRails/log/moteinoAndPi.log`.split("\n")


    #file = Rails.root + "/log/moteinoAndPi.log"
    file = File.join(Rails.root, 'log','moteinoAndPi.log')
    if file.nil?
      return @logs = ""
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
end
