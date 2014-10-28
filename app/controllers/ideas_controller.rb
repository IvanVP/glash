class IdeasController < ApplicationController
  
  def index
  end

  def show
    @idea = Ideas.find(params[:id])
    @idea.increase!("views")
  end

end
