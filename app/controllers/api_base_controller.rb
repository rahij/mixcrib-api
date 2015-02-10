class ApiBaseController < ApplicationController
  before_action :cors_preflight_check, :initialize_response, :authenticate_request
  after_action :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Content-Type'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def initialize_response
    @response = {}
    @status = :ok
  end

  def authenticate_request
    auth_params = params[:auth]
    @requested_user = User.find(auth_params[:id]) rescue nil
    unless @requested_user && @requested_user.valid_token?(auth_params[:auth_token])
      @status = :unauthorized
      end_request
    end
  end

  def end_request
    render json: @response, status: @status
  end
end
