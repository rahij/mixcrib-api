class PlaylistsController < ApiBaseController
  def index
    @playlists = @requested_user.playlists
    @response = @playlists
    end_request
  end

  def create
    @playlist = @requested_user.playlists.new(playlist_params)
    @status = :bad_request unless @playlist.save
    @response = @playlist
    end_request
  end

  def show
    requested_playlist = Playlist.find(params[:id]) rescue nil
    @status = :bad_request unless requested_playlist
    if requested_playlist && requested_playlist.is_visible_to?(@requested_user)
      @response = requested_playlist
    else
      @status = :unauthorized
    end
    end_request
  end

  private

  def playlist_params
    json_params = ActionController::Parameters.new(params)
    json_params.require(:playlist).permit(:name)
  end
end
