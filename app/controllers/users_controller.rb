class UsersController < ApiBaseController
  before_action :authenticate_current_user, except: [:create]
  skip_before_action :authenticate_request, only: [:create]

  def create
    @json = User.create(params)
  end

  def show
    @json = @requested_user
  end

  def update
  end

  def destroy
    User.destroy(params[:id])
  end

  private

  def authenticate_current_user
    unless @requested_user.id == params[:id]
      @status = :unauthorized
      end_request
    end
  end
end
