class ElementsController < ApplicationController
   before_action :require_login, :set_user


  def index
     @instruments = @user.instruments
     @songs = @user.songs
     @elements = @user.elements.filter_by(params.slice(:lyrics?, :e_name, :key, :tempo, :learned, :instrument, :song))
  end

   def new
     if params[:song_id] && song = Song.find(params[:song_id])
         @element = song.elements.build
     elsif Song.all.empty?
           flash[:notice] = 'Enter a song first!'
           redirect_to new_user_song_path(@user)
     else
         @element = Element.new
     end
   end

   def create
     @element = Element.new(element_params)
     if @element.save
       song = @element.song
       instrument = @element.instrument
       if !song.instruments.include?(instrument)
         song.instruments << instrument
       end
      redirect_to user_element_path(@user, @element)
     else
       render 'new'
     end
   end

   def show
     set_element
     @song = @element.song
   end

   def edit
    set_element
   end

   def update
     set_element
     if @element.update(element_params)
       redirect_to element_path(@element)
     else
       render 'edit'
     end
   end

   def destroy
     set_element
     @element.destroy
     redirect_to user_elements_path(@user)
   end



   private

   def set_element
     @element = Element.find(params[:id])
     if !@element
       redirect_to user_elements_path
     end
   end



   def element_params
     params.require(:element).permit(:lyrics, :e_name, :learned, :tempo, :key, :sheet_music, :delete_sheet_music, :recording, :delete_recording, :instrument_id, :song_id, :user_id)
   end

end
