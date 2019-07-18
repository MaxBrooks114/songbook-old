class ElementsController < ApplicationController
   before_action :set_user

  def index
     @instruments = @user.instruments
     @songs = @user.songs
     @elements = Element.filter_by(params.slice(:e_name, :key, :tempo, :learned, :instrument, :song))
  end

   def new
     if params[:song_id] && song = Song.find(params[:song_id])
         @element = song.elements.build
     else
         @element = Element.new
     end
   end

   def create
     @element = Element.new(element_params)
     @element.user_id = current_user.id if current_user
     if @element.save
       song = @element.song
       instrument = @element.instrument
       if !song.instruments.include?(instrument)
         song.instruments << instrument
       end
      redirect_to user_element_path(@user, @element)
     else
       flash[:notice] = @element.errors.messages
       redirect_to new_user_element_path
     end
   end

   def show
     @element = Element.find(params[:id])
     @song = @element.song
   end

   def edit
     @element = Element.find(params[:id])
   end

   def update
     element = Element.find(params[:id])
     element.update(element_params)
     song =  element.song
     redirect_to element_path(element)
   end

   def destroy
     @element = Element.find(params[:id])
     @element.destroy
     redirect_to user_elements_path(current_user)
   end


   private

   def element_params
     params.require(:element).permit(:e_name, :learned, :tempo, :key, :instrument_id, :song_id)
   end

end
