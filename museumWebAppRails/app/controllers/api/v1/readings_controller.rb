class Api::V1::ReadingsController < Api::V1::BaseController
  def create
    pp "***************************"
    pp "In Reading create"
    pp reading_params
    pp "****************************"

    if(!reading_params[:error].nil?)
      # render(:alert => 'Error received', :status => 200)
      render(json: {
        status: 200,
        message: "Received error"
      }.to_json,
      :status => 200)
      #We should probably add this erorr to our logs

    elsif(!reading_params[:temp].nil?) #This means it is a vaild reading
      pp"********************"
      pp "This is a reading not an error"
      pp "********************"
      #Is this a node we haven't seen before?
      if(Node.find_by(node_id: reading_params[:node_id]).nil?)
        pp"**************"
        pp "Node not found so creating a new one"
        pp "****************"
        Node.create(:node_id => reading_params[:node_id])  #Create and save a new node
      end

      #Is this a sensor we haven't seen before?
      if(Sensor.find_by(node_id: reading_params[:node_id], pin: reading_params[:pin]).nil?)
        pp "***********"
        pp "Pin not found so creating a new one"
        pp "***********"
        Sensor.create(:node_id => reading_params[:node_id],
          :pin => reading_params[:pin])
      end
      
      pp "*************"
      pp "Saving reading"
      pp "*************"
      #Finally we can save the reading
      @reading = Reading.new(:temperature => reading_params[:temp],
        :humidity => reading_params[:hum],
        :recorded_at => reading_params[:timeStamp],
        :node_id => reading_params[:node_id],
        :pin => reading_params[:pin])
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
          status: 400,
          message: "There was an error saving the data",
          params: reading_params
        }.to_json,
        :status => 400)
      end
    else
      render(json: {
        status: 400,
        message: "The json object supplied was invalid",
        params: reading_params
      }.to_json,
      :status => 400)
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.permit(:temp, :hum, :timeStamp, :volt, :node_id, :pin, :error) #Add nodeID
    end
end