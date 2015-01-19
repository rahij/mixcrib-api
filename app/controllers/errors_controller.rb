class ErrorsController < ApplicationController
  def not_found
    render json: {}, status: :not_found
  end

  def exception
    render json: {}, status: :internal_server_error
  end
end