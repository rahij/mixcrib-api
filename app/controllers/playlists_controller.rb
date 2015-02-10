class PlaylistsController < ApiBaseController
  def create
    @playlist = @requested_user.playlists.new(playlist_params)
    @status = :bad_request unless @playlist.save
    @response = @playlist
    end_request
  end

  private

  def playlist_params
    json_params = ActionController::Parameters.new(params)
    json_params.require(:playlist).permit(:name)
  end
end
