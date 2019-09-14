class InstrumentsController < ApplicationController
   before_action :require_login, :set_user
   skip_before_action :verify_authenticity_token
   def index
     if params[:family]
        @instrument = @user.instruments.find_by(family: params[:family])
     end
     @instruments = @user.instruments.filter_by(params.slice(:range, :family, :make))
     respond_to do |f|
       f.html {render :index}
       f.json {render json: @instruments}
    end
  end

   def new
     @instrument = Instrument.new
   end

   def create
     @instrument = Instrument.new(instrument_params)
     if @instrument.save
       # redirect_to user_instrument_path(@user, @instrument)
       respond_to do |f|
          f.html {redirect_to user_instrument_path(@user, @instrument)}

          f.json {render json: @instrument.to_json(include: [:songs, :elements])}
        end
     else
       render 'new'
     end
   end

   def show
     set_instrument
     respond_to do |f|
        f.html {render :show}

        f.json {render json: @instrument}

    end
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
       redirect_to user_instruments_path(@user)
     end
   end

   def instrument_params
     params.require(:instrument).permit(:i_name, :make, :model, :picture, :delete_picture, :family, :range, :user_id)
   end
end
