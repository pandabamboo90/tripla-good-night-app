class ApplicationController < ActionController::API

  before_action :set_current_user
  def set_current_user
    @current_user = User.find(request.headers['current-user-id'])
  end

  def index
    render json: { message: 'API online' }
  end
end
