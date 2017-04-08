class ReadingsController < ApplicationController
  before_action :set_reading, only: [:show, :edit, :update, :destroy]
  #Added to make sure that only logged in users can access our site
  before_action :require_login 
  # GET /readings
  # GET /readings.json
  def index

    @hidden = "true"
    @last_20 = Reading.select(:node_id, :name, :recorded_at, :temperature, :humidity).last(20).sort_by { |m| m[:recorded_at] }.reverse
    @node_names = Node.select(:node_id, :name)

    # Specify date range
    if(!params[:start_date].nil? && !params[:end_date].nil?) then
      @startDate = Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
      @endDate = Date.civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i)
      # The globals are meant for if users want csv's or xls' of files
      $fileStartDate = @startDate
      $fileEndDate = @endDate
    # Default (no args) will be the current date
    else    
      @startDate = Date.today.beginning_of_day
      @endDate = Date.today.end_of_day
    end
    # Query the data
    @readings = Reading.select(:node_id, :name, :recorded_at, :temperature, :humidity).where(recorded_at: @startDate.beginning_of_day..@endDate.end_of_day)
    respond_to do |format|
      format.html
      format.csv { send_data Reading.order(:name, :recorded_at).select(:node_id, :name, :recorded_at, :temperature, :humidity).where(recorded_at: $fileStartDate.beginning_of_day..$fileEndDate.end_of_day).to_csv }
      format.xls { 
                   send_data Reading.order(:name, :recorded_at).select(:node_id, :name, :recorded_at, :temperature, :humidity).where(recorded_at: $fileStartDate.beginning_of_day..$fileEndDate.end_of_day).to_csv(col_sep: "\t")
                 }
    end
  end

  # GET /readings/1
  # GET /readings/1.json
  def show
  end

  # GET /readings/new
  def new
    @reading = Reading.new
  end


  # POST /readings
  # POST /readings.json
  def create
    @reading = Reading.new(reading_params)

    respond_to do |format|
      if @reading.save
        format.html { redirect_to @reading, notice: 'Reading was successfully created.' }
        format.json { render :show, status: :created, location: @reading }
      else
        format.html { render :new }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /readings/1
  # DELETE /readings/1.json
  def destroy
    @reading.destroy
    respond_to do |format|
      format.html { redirect_to readings_url, notice: 'Reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reading
      @reading = Reading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_params
      params.fetch(:reading, {})
    end

end
