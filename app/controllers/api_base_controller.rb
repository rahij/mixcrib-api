class ApiBaseController < ApplicationController
  before_action :initialize_response, :authenticate_request
  after_action :end_request

  private

  def initialize_response
    @json = {}
    @status = :ok
  end

  def authenticate_request
    @requested_user = User.find(params[:id]) rescue nil
    unless @requested_user && @requested_user.authentic?
      @status = :unauthorized
      end_request
    end
  end

  def end_request
    render json: @json, status: @status
  end
end
