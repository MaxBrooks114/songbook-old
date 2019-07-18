class InstrumentsController < ApplicationController

  def index
    @user = current_user
    @instruments = instrument.filter_by(params.slice(:range, :family))
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
       redirect_to user_instrument_path(@user, @instrument)
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
     redirect_to user_instrument_path(@user, instrument)
   end

   def destroy
     @user = current_user
     @instrument = Instrument.find(params[:id])
     @instrument.destroy
     redirect_to user_instruments_path(@user)
   end


   private

   def instrument_params
     params.require(:instrument).permit(:i_name, :family, :range)
   end
end
