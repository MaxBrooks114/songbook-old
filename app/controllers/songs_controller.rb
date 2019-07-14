class SongsController < ApplicationController

   def index
     @user = current_user
     @instruments = Instrument.all
    if !params[:instruments].blank?
        @songs = Song.where(instruments: params[:instruments])
    elsif !params[:genre].blank?
        @songs = Song.where(genre: params[:genre])
    elsif !params[:artist].blank?
        @songs = Song.where(artist: params[:artist])
    elsif !params[:album].blank?
        @songs = Song.where(album: params[:album])
    else
      @songs = Song.all
    end
   end

  def new
    @user = current_user
    @instruments = Instrument.all
    if params[:instrument_id] && instrument = Instrument.find(params[:instrument_id])
        @song = instrument.songs.build
        @song.instruments << instrument
    elsif Instrument.all.empty?
        redirect_to new_instrument_path
    else
        @song = Song.new
    end
  end

  def create
    @user = current_user
    @song = Song.new(song_params)
    if @song.save
      redirect_to song_path(@song)
    else
      flash[:notice] = @song.errors.messages
      redirect_to new_song_path
    end
  end

  def show
    @user = current_user
    @song = Song.find(params[:id])
  end

  def edit
    @user = current_user
    @instruments = Instrument.all
    @song = Song.find(params[:id])
  end

  def update
    @user = current_user
    song = Song.find(params[:id])
    song.update(song_params)
    redirect_to song_path(song)
  end

  def destroy
    @user = current_user
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end


  private

  def song_params
    params.require(:song).permit(:title, :lyrics, :artist, :genre, :album, :learned, instrument_ids: [], elements_attributes: [:id, :name, :key, :tempo, :learned, :instrument_id, :_destroy] )
  end
end
