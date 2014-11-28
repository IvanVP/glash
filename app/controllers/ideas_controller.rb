class IdeasController < ApplicationController
  before_action :authenticate_user!,  except: [:show, :index]
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :vote, :moderate]

  filter_resource_access
  filter_access_to :vote, :moderate


  def index
    @ideas = Idea.includes(:assets, :votes_for).active
    @ideas_unmoderated = Idea.includes(:assets, :votes_for).published
    @ideas_drafted = Idea.includes(:assets, :votes_for).drafted
  end

  def show
    if @idea.user == current_user || @idea.moderated || current_user.is_administrator?
      @images= @idea.assets
      @comments = @idea.comments.order(created_at: :desc)
      @idea.increment!("views") unless @idea.user == current_user
      flash.now[:alert] = "Идея находится в архиве." if @idea.archieved
      flash.now[:alert] = "Идея не опубликована." unless @idea.published 
    else
      redirect_to ideas_path, alert: "Извините, Вы не можете сделать это действие (недостаточно прав или запрещен доступ)."
    end
  end
  
  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id

    if @idea.save
      redirect_to idea_submit_path( @idea, :info)
    else
      render "new"
    end
    
  end

  def update
    notice = 'Ваша идея успешно изменена.'
    if params[:idea][:published] == '1'
      @idea.published = true
      @idea.published_at = Time.now
      notice = 'Ваша идея опубликована и ожидает модерации.'
    elsif params[:idea][:published] == '0'
      @idea.published = false
      @idea.published_at = nil
      notice = nil
    end

    if @idea.update(idea_params)
      redirect_to @idea, notice: notice 
    else
      render :edit
    end
  end

  def destroy
    if @idea.user == current_user && !@idea.published  
      @idea.destroy
      redirect_to :back, notice: 'Ваша идея успешно удалена.'
    end
  end

  def vote
    @idea.liked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.js
      # format.json { render json: { count: @idea.liked_count, id: @idea.id } }
    end
  end

  def moderate

    @idea.moderated = true
    @idea.moderated_at = Time.now
    @idea.moderator_id = current_user.id

    if @idea.save
      respond_to do |format|
        format.html { redirect_to :back, notice: "Идея успешно модерирована и появилась на сайте." }
        # format.js {render :layout => false}
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: "Идея не модерирована и не появилась на сайте." }
        # format.js {render :layout => false}
      end
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # not needed with declarative authorization
    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:agree, :title, :synopsis, :problem, :background, :solution, :links, :category_id, :published, :moderated, :status, assets_attributes: :data, :data => :data)
      
    end
    
end
