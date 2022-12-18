class SleepRecordsController < ApplicationController

  before_action :set_user
  before_action :set_sleep_record, only: %i[ show update destroy ]

  # GET /users/:user_id/sleep_records
  def index
    @sleep_records = SleepRecord.all

    render json: @sleep_records
  end

  # GET /users/:user_id/sleep_records/1
  def show
    render json: @sleep_record
  end

  # POST /users/:user_id/sleep_records
  def create
    @sleep_record = @user.add_sleep_record!(sleep_record_params: sleep_record_params)
    render json: @sleep_record
  end

  # PUT/PATCH /users/:user_id/sleep_records/:id
  def update
    @sleep_record = @user.update_sleep_record!(sleep_record: @sleep_record,
                                               sleep_record_params: sleep_record_params)
    render json: @sleep_record
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_sleep_record
    @sleep_record = SleepRecord.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sleep_record_params
    params.require(:sleep_record).permit(:started_at, :ended_at)
  end
end
