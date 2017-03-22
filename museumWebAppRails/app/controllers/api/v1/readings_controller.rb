class Api::V1::ReadingsController < Api::V1::BaseController
  def create
    pp "***************************"
    pp "In Reading create"
    pp reading_params[:node_id]
    pp "****************************"

    #There is an authorization header && it contains a valid password
    if((!request.headers['Authorization'].nil?) && (request.headers['Authorization'] == 'rasPiAuth..0246'))
      pp "***********"
      pp "Authorization succesful"
      pp "*************"
        if(!reading_params[:error].nil?)
          render(json: {
            status: 200,
            message: "Received error"
          }.to_json,
          :status => 200)
          ####### TODO:  We should probably add this erorr to our logs
          path = File.join(Rails.root, 'log','moteinoAndPi.log')
          File.open(path, 'a') { |f|
          f.puts reading_params.to_json << "\n"
        }
       #how would I write out a json? could i c&p the above render()?


        elsif(!reading_params[:temp].nil? && !reading_params[:hum].nil?) #TWe have temp and hum so it is a valid reading
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

          #Update the node voltage and most recent reading timeStamp
          node = Node.find_by(node_id: reading_params[:node_id])
          node.voltage = reading_params[:volt]
          node.last_reading = reading_params[:timeStamp]
          pp "*************"
          pp "Saving reading"
          pp "*************"
          #Save the reading
          @reading = Reading.new(:name => Node.find_by(node_id: reading_params[:node_id]).name,
            :temperature => reading_params[:temp],
            :humidity => reading_params[:hum],
            :recorded_at => reading_params[:timeStamp],
            :node_id => reading_params[:node_id])

          pp "**********"
          pp @reading.name
          pp "*************"


          if @reading.save && node.save
            #200 means everything went well
            render(json: {
              status: 200,
              message: "Save succesful",
              reading: @reading
            }.to_json,
            :status => 200)

          #reading save failed
          else
            render(json: {
              status: 400,
              message: "There was an error saving the data",
              params: reading_params
            }.to_json,
            :status => 400)
          end

        #The supplied json didn't contain a temp field so it isn't valid
        else
          render(json: {
            status: 400,
            message: "The json object supplied was invalid",
            params: reading_params
          }.to_json,
          :status => 400)
        end

      #Supplied creds were bad
      else
        render(json: {
          status: 401,
          message: "Bad credentials",
        }.to_json,
        :status => 401)
      end
      end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.permit(:temp, :hum, :timeStamp, :volt, :node_id, :error)
    end
end
