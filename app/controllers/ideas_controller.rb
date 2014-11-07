class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def index
    @ideas = Idea.all
    # @ideas = Idea.published
  end

  def show
    @idea.increment!("views")
  end
  
  def new
    @idea = Idea.new
  end

  def edit
    redirect_to idea_submit_path( @idea, :info)
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id

    if @idea.save
      redirect_to idea_submit_path( @idea, :info)
      # redirect_to @idea, notice: "Ваша идея сохранена"
    else
      render "new"
    end
    
  end

  def update
    if params[:idea][:published]
      @idea.published_at = Time.now
    end

    if @idea.update(idea_params)
      redirect_to @idea, notice: 'Ваша идея успешно изменена.' 
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url, notice: 'Ваша идея успешно удалена.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:agree, :title, :synopsis, :problem, :background, :solution, :links, :category_id, :published, :moderated, :status, assets_attributes: :data, :data => :data)
      # (:agree, :title, :synopsis, :problem, :background, :solution, :links, :category_id, assets_attributes: :data, :data => :data)
    end
    
end
