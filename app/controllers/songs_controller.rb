# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :require_login, :set_user

  def index
    @songs = @user.songs.filter_by(params.slice(:artist, :album, :genre, :instruments))
    respond_to do |f|
      f.html { render :index }
      f.json { render json: @songs }
    end
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
    respond_to do |f|
      f.html { render :show }
      f.json do
        render json: @song.to_json(only: %i[id title lyrics genre album],
                                   include: [instruments: { only: [:i_name] }, elements: { only: [:e_name] }])
      end
    end
  end

  def edit
    set_song
    @instruments = @user.instruments
  end

  def update
    set_song
    @instruments = @user.instruments
    if @song.update(song_params)
      @song.elements.each do |e|
        e.destroy unless @song.instruments.include?(e.instrument)
      end
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
    redirect_to user_songs_path(@user) unless @song
  end

  def song_params
    params.require(:song).permit(:title, :lyrics, :artist, :genre, :album, :learned, :user_id, :instrument_id, instrument_ids: [], elements_attributes: %i[id lyrics e_name key tempo learned recording delete_recording sheet_music delete_sheet_music user_id instrument_id _destroy])
  end
end
