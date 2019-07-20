class InstrumentsController < ApplicationController
   before_action :require_login, :set_user

   def index
     @instruments = @user.instruments.filter_by(params.slice(:range, :family))
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
     set_instrument
   end

   def edit
     set_instrument
   end

   def update
     set_instrument
     if @instrument.update(instrument_params)
       redirect_to user_instrument_path(@user, @instrument)
     else
      render 'edit'
   end
 end

   def destroy
     set_instrument
     @instrument.destroy
     redirect_to user_instruments_path(@user)
   end


   private

   def set_instrument
     @instrument = Instrument.find(params[:id])
     if !@instrument
       redirect_to user_instruments_path
     end
   end

   def instrument_params
     params.require(:instrument).permit(:i_name, :picture, :delete_picture, :family, :range, :user_id)
   end
end
