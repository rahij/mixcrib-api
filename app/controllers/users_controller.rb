class UsersController < ApiBaseController
  skip_filter :authenticate_request, only: [:create, :auth]

  def create
    @user = User.new(user_params)
    @status = :bad_request unless @user.save
    @response = @user
    end_request
  end

  def show
    if params[:id] && @requested_user.id != params[:id].to_i
      # render public profile
      @response = User.find(params[:id]).public_profile
    else
      @response = @requested_user
    end
    end_request
  end

  def update
  end

  def destroy
    User.destroy(params[:id])
    end_request
  end

  def auth
    user = User.where(email: params[:email]).last
    if user && user.authenticate(params[:password])
      # user.regenerate_auth_token!
      @response = { id: user.id,  auth_token: user.auth_token }
    else
      @status = :unauthorized
    end
    end_request
  end

  private

  def user_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:user).permit(:email, :password)
  end
end
