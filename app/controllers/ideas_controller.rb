class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote]

  def index
    @ideas = Idea.includes(:assets, :votes_for).all
    # @ideas = Idea.published
  end

  def show
    @images= @idea.assets.order(created_at: :asc)
    @comments = @idea.comments
    @idea.increment!("views")
  end
  
  def new
    @idea = Idea.new
  end

  def edit
    redirect_to idea_submit_path(@idea, :info)
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
    notice = 'Ваша идея успешно изменена.'
    if params[:idea][:published]
      @idea.published_at = Time.now
      notice = 'Ваша идея опубликована и ожидает модерации.'
    end

    if @idea.update(idea_params)
      redirect_to @idea, notice: notice 
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url, notice: 'Ваша идея успешно удалена.'
  end

  def vote
    @idea.liked_by current_user
    p @idea.vote_registered?
    respond_to do |format|
      format.html {redirect_to :back }
      format.js
      # format.json { render json: { count: @idea.liked_count, id: @idea.id } }
    end
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
