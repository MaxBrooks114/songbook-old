class ElementsController < ApplicationController

  def destroy
    @element = Element.find(params[:id])
    @element.destroy
  end

end
