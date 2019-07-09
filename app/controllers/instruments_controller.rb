class InstrumentsController < ApplicationController
skip_before_action :verify_authenticity_token
  def index
     @instruments = Instrument.all
   end

   def new
     @instrument = Instrument.new
   end

   def create
     @instrument = Instrument.new(instrument_params)
     if @instrument.save
       redirect_to instrument_path(@instrument)
     else
       flash[:notice] = @instrument.errors.messages
       redirect_to new_instrument_path
     end
   end

   def show
     @instrument = Instrument.find(params[:id])
   end

   def edit
     @instrument = Instrument.find(params[:id])
   end

   def update
     instrument = Instrument.find(params[:id])
     instrument.update(instrument_params)
     redirect_to instrument_path(instrument)
   end

   def destroy
     @instrument = Instrument.find(params[:id])
     @instrument.destroy
     redirect_to instruments_path
   end


   private

   def instrument_params
     params.require(:instrument).permit(:name, :family, :range)
   end
end
