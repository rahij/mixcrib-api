class ApiBaseController < ApplicationController
  before_action :allow_cors, :initialize_response, :authenticate_request

  def allow_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def initialize_response
    @response = {}
    @status = :ok
  end

  def authenticate_request
    @requested_user = User.find(params[:id]) rescue nil
    unless @requested_user && @requested_user.valid_token?(params[:auth_token])
      @status = :unauthorized
      end_request
    end
  end

  def end_request
    render json: @response, status: @status
  end
end
