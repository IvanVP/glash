class SubmitController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :update]

  steps :info, :idea, :images

  filter_access_to :show, :edit, :update, :finish_wizard_path


  def show
    if @idea.user == current_user && !@idea.published
      @existing_assets = @idea.assets if step == :images
      render_wizard
    else
      redirect_to ideas_path, alert: "Извините, Вы не можете сделать это действие (недостаточно прав или запрещен доступ)."
    end
  end

  def update
    params[:idea][:status] = step
    @idea.update(idea_params)
    render_wizard @idea
  end

  def finish_wizard_path
    idea_path(@idea)
  end

  private
    def set_idea
      @idea = Idea.find(params[:idea_id])
    end

    def idea_params
      params.require(:idea).permit(:agree, :idea_id, :title, :synopsis, :problem, :background, :solution, :links, :category_id, :status, assets_attributes: :data, :data => :data)
    end

end
