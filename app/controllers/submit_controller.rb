class SubmitController < ApplicationController
  include Wicked::Wizard

  steps :info, :idea, :images

  def show
    @idea = Idea.find(params[:idea_id])
    render_wizard
  end


  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to idea_submit_path(@idea, :info)
    else
      render "new"
    end
  end

  def update
    @idea = Idea.find(params[:idea_id])
    @idea.update(idea_params)
    render_wizard @idea
  end

  def finish_wizard_path
    idea_path(@idea)
  end

  private

    def idea_params
      params.require(:idea).permit(:agree, :idea_id, :title, :synopsis, :problem, :background, :solution, :links, :category_id, assets_attributes: :data, :data => :data)
    end

end
