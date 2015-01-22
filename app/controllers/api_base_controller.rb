class ApiBaseController < ApplicationController
  before_action :initialize_response, :authenticate_request

  private

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
