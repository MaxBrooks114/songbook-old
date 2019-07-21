class SongsController < ApplicationController
   before_action :require_login, :set_user
   def index
     @instruments = @user.instruments
     @songs = @user.songs.filter_by(params.slice(:artist, :album, :genre, :instruments))
   end

  def new
    @instruments = @user.instruments
    if params[:instrument_id] && instrument = Instrument.find(params[:instrument_id])
        @song = instrument.songs.build
        @song.instruments << instrument
    elsif Instrument.all.empty?
        flash[:notice] = 'Enter a new instrument first!'
        redirect_to new_user_instrument_path(@user)
    else
        @song = Song.new
    end
  end

  def create
    @instruments = @user.instruments
    @song = Song.new(song_params)
    if @song.save
      redirect_to user_song_path(@user, @song)
    else
      render 'new'
    end
  end

  def show
    set_song

  end

  def edit
    set_song
    @instruments = @user.instruments

  end

  def update
    set_song
    @instruments = @user.instruments
    if @song.update(song_params)
      redirect_to song_path(@song)
    else
      render 'edit'
    end
  end

  def destroy
    set_song
    @song.destroy
    redirect_to user_songs_path(@user)
  end


  private

  def set_song
    @song = Song.find(params[:id])
    if !@song
      redirect_to user_songs_path(@user)
    end
  end

  def song_params
    params.require(:song).permit(:title, :lyrics, :artist, :genre, :album, :learned, :user_id, instrument_ids: [], elements_attributes: [:id, :lyrics, :e_name, :key, :tempo, :learned, :recording, :delete_recording, :sheet_music, :delete_sheet_music, :user_id, :instrument_id, :_destroy] )
  end
end
