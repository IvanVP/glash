class IdeasController < ApplicationController

  def index
  end

  def show
    @idea = Ideas.find(params[:id])
    @idea.increase!("views")
  end
  
  def new
    @idea = Idea.new
    
  end
  def create
      idea = Idea.new(params[:idea])
      idea.user_id = current_user.id
      if idea.save
        redirect_to idea, notice: "Ваша идея сохранена"
      else
        # This line overrides the default rendering behavior, which
        # would have been to render the "create" view.
        render "new"
      end
    end

end
