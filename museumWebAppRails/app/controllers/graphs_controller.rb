class GraphsController < ApplicationController
	def show
		#render template: "pages/#{params[:page]}" #TOOD: Do we need this? we don't have a show view...
	end

	def index
		@someValue = "I could be a list, or an int, or anything..."
		@anotherValue = "I'm another value and I can be anything too."
		#We should build the arrays there in the controller and then pass them to the view.
	end


end
