class InstrumentsController < ApplicationController

  def index
    @user = current_user
    if !params[:family].blank?
      @instruments = @user.instruments.where(family: params[:family])
    elsif !params[:range].blank?
      @instruments = @user.instruments.where(range: params[:range])
    else
      @instruments = @user.instruments
    end
   end

   def new
     @user = current_user
     @instrument = Instrument.new
   end

   def create
     @user = current_user
     @instrument = Instrument.new(instrument_params)
     @instrument.user_id = current_user.id if current_user
     if @instrument.save
       redirect_to user_instrument_path(current_user, @instrument)
     else
       flash[:notice] = @instrument.errors.messages
       redirect_to new_user_instrument_path
     end
   end

   def show
     @user = current_user
     @instrument = Instrument.find(params[:id])
   end

   def edit
     @user = current_user
     @instrument = Instrument.find(params[:id])
   end

   def update
     @user = current_user
     instrument = Instrument.find(params[:id])
     instrument.update(instrument_params)
     redirect_to user_instrument_path(current_user, instrument)
   end

   def destroy
     @user = current_user
     @instrument = Instrument.find(params[:id])
     @instrument.destroy
     redirect_to user_instruments_path
   end


   private

   def instrument_params
     params.require(:instrument).permit(:name, :family, :range)
   end
end
