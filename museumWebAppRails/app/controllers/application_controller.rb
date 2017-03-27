class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  #Added to make sure that only logged in users can access our site
	before_action :require_login 

  	helper_method :test_method

  	def group_by_date(start_date, end_date)
		@readings = Reading.all 

		@readings.each do |p|
			pp 'Text'
		end
	end
end
