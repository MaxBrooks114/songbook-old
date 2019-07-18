class SongsController < ApplicationController
   before_action :set_user
   def index
     @instruments = @user.instruments
     @songs = Song.filter_by(params.slice(:artist, :album, :genre, :instruments))
   end

  def new
    @instruments = @user.instruments
    if params[:instrument_id] && instrument = Instrument.find(params[:instrument_id])
        @song = instrument.songs.build
        @song.instruments << instrument
    elsif Instrument.all.empty?
        redirect_to new_user_instrument_path(@user)
    else
        @song = Song.new
    end
  end

  def create
    @song = Song.new(song_params)
    @song.user_id = current_user.id if current_user
    if @song.save
      redirect_to user_song_path(@user, @song)
    else
      redirect_to new_user_song_path(@user)
    end
  end

  def show
    @song = Song.find(params[:id])
  end

  def edit
    @instruments = Instrument.all
    @song = Song.find(params[:id])
  end

  def update
    song = Song.find(params[:id])
    song.update(song_params)
    redirect_to song_path(song)
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end


  private

  def song_params
    params.require(:song).permit(:title, :lyrics, :artist, :genre, :album, :learned, :user_id, instrument_ids: [], elements_attributes: [:id, :e_name, :key, :tempo, :learned, :user_id, :instrument_id, :_destroy] )
  end
end
