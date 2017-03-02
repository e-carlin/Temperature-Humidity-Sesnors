class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  	helper_method :test_method

  	def group_by_date(start_date, end_date)
		@readings = Reading.all 

		@readings.each do |p|
			pp 'Text'
		end
	end
end
