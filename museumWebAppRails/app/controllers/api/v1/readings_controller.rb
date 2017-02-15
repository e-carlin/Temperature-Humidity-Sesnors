class Api::V1::ReadingsController < Api::V1::BaseController
  def create
  	pp "***************************"
  	pp "In API create"
  	pp reading_params
  	pp "****************************"

    if(!reading_params[:error].nil?)
      # render(:alert => 'Error received', :status => 200)
      render(json: {
        status: 200,
        message: "Received error"
      }.to_json,
      :status => 200)
      #Then handle the error
      # This type of error means either the Pi or the moteino is 
      # having a problem
      # Return status 200 saying you received the error

    else #This means it is a vaild reading
        #if(SELECT from Nodes where networkID = reading_params[:node_id] == NULL)
          #add the node id to the db
        #if(SELECT from Sensors where sID = reading_params[:sID] == NULL)
          #add the sensor to the db

        #Then proceeed with code below  

      @reading = Reading.new(:temperature => reading_params[:temp],
        :humidity => reading_params[:hum],
        :recorded_at => reading_params[:timeStamp])
        #add nodeID and sensorID


      if @reading.save
        #200 means everything went well
        render(json: {
          status: 200,
          message: "Save succesful",
          reading: @reading
        }.to_json,
        :status => 200)
      else
        render(json: {
          status: 200,
          message: "There was an error saving the data",
          params: reading_params
        }.to_json,
        :status => 400)
      end
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.permit(:temp, :hum, :timeStamp, :volt, :sID, :error) #Add nodeID
    end
end