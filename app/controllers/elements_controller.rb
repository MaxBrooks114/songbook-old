class ElementsController < ApplicationController

  def index
     @elements = Element.all
   end

   def new
     @element = Element.new
   end

   def create
     @element = Element.new(element_params)
     if @element.save
       redirect_to element_path(@element)
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
     redirect_to element_path(element)
   end

   def destroy
     @element = Element.find(params[:id])
     @element.destroy
     redirect_to elements_path
   end


   private

   def element_params
     params.require(:element).permit(:name, :learned, :instrument_id, :song_id)
   end
end
