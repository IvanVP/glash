class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def index
    @ideas = Idea.all
  end

  def show
    @idea.increment!("views")
  end
  
  def new
    @idea = Idea.new
    # 7.times {@idea.idea_images.build}
  end

  def edit
    # 7.times {@idea.idea_images.build}
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    if @idea.save
      redirect_to @idea, notice: "Ваша идея сохранена"
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: 'idea was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url, notice: 'idea was successfully destroyed'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :synopsis, :problem, :background, :solution, :links, :category_id, idea_images_attributes: [ :image, :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
    end


end
