class Api::V1::ReadingsController < Api::V1::BaseController
  def create
  	pp "***************************"
  	pp "In API create"
  	pp reading_params
  	pp "****************************"
    @reading = Reading.new(:temperature => reading_params[:temp],
    	:humidity => reading_params[:hum],
    	:recorded_at => reading_params[:timeStamp])


    if @reading.save
    	#200 means everything went well
      render(:nothing => true, :status => 200)
    else
      render(:alert => "The data could not be saved",  :status => 400)
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.permit(:temp, :hum, :timeStamp)
    end
end