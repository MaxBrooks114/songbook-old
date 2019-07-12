class ElementsController < ApplicationController

  def index
     @instruments = Instrument.all
     @songs = Song.all
     if !params[:instrument].blank?
         @elements = Element.where(instrument: params[:instrument])
     elsif !params[:song].blank?
         @elements = Element.where(song: params[:song])
     elsif !params[:key].blank?
         @elements = Element.where(key: params[:key])
     elsif !params[:tempo].blank?
         @elements = Element.where(tempo: params[:tempo])
     elsif !params[:learned].blank?
         @elements = Element.where(learned: params[:learned])
     else
       @elements = Element.all
    end
   end

   def new
     if params[:song_id] && song = Element.find(params[:song_id])
         @element = song.elements.build
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
         redirect_to element_path(element)
       else
         redirect_to element_path(element)
       end
     else
       flash[:notice] = @element.errors.messages
       redirect_to new_element_path
     end
   end

   def show
     @element = Element.find(params[:id])
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
     redirect_to elements_path
   end


   private

   def element_params
     params.require(:element).permit(:name, :learned, :tempo, :key, :instrument_id, :song_id)
   end
end
