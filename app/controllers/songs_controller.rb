class SongsController < ApplicationController

   def index
     @songs = Song.all
   end

  def new
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
    @song = Song.new(song_params)
    if @song.save
      redirect_to song_path(@song)
    else
      flash[:notice] = @song.errors.messages
      redirect_to new_song_path
    end
  end

  def show
    @song = Song.find(params[:id])
  end

  def edit
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
    params.require(:song).permit(:title, :lyrics, :artist, :genre, :album, :learned, instrument_ids: [], elements_attributes: [:id, :name, :learned, :instrument_id, :_destroy] )
  end
end
