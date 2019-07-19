class InstrumentsController < ApplicationController
   before_action :set_user
   def index
     @instruments = Instrument.filter_by(params.slice(:range, :family))
   end

   def new
     @instrument = Instrument.new
   end

   def create
     @instrument = Instrument.new(instrument_params)
     if @instrument.save
       redirect_to user_instrument_path(@user, @instrument)
     else
       render 'new'
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
     redirect_to user_instrument_path(@user, instrument)
   end

   def destroy
     @instrument = Instrument.find(params[:id])
     @instrument.destroy
     redirect_to user_instruments_path(@user)
   end


   private

   def instrument_params
     params.require(:instrument).permit(:i_name, :family, :range, :user_id)
   end
end
