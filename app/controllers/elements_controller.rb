class ElementsController < ApplicationController

  def index
     @user = current_user
     @instruments = @user.instruments
     @songs = @user.songs
     if !params[:instrument].blank?
         @elements = Element.where(instrument: params[:instrument])
     elsif !params[:song].blank?
         @elements = Element.where(song: params[:song])
     elsif !params[:name].blank?
           @elements = Element.where(name: params[:name])
     elsif !params[:key].blank?
         @elements = Element.where(key: params[:key])
     elsif !params[:tempo].blank?
         @elements = Element.where(tempo: params[:tempo])
     elsif !params[:learned].blank?
         @elements = Element.where(learned: params[:learned])
     else
       @elements = @user.elements
    end
   end

   def new
      @user = current_user
     if params[:song_id] && song = Song.find(params[:song_id])
         @element = song.elements.build
     else
         @element = Element.new
     end
   end

   def create
     @user = current_user
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
     @user = current_user
     @element = Element.find(params[:id])
     @song = @element.song
   end

   def edit
     @user = current_user
     @element = Element.find(params[:id])
   end

   def update
     @user = current_user
     element = Element.find(params[:id])
     element.update(element_params)
     song =  element.song
     redirect_to element_path(element)
   end

   def destroy
     @user = current_user
     @element = Element.find(params[:id])
     @element.destroy
     redirect_to user_elements_path(current_user)
   end


   private

   def element_params
     params.require(:element).permit(:name, :learned, :tempo, :key, :instrument_id, :song_id)
   end
end
