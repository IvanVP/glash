class SubmitController < ApplicationController
  include Wicked::Wizard

  steps :info, :idea, :images

  def show
    @idea = Idea.find(params[:idea_id])
    render_wizard
  end


  def create
    @idea = Idea.new(idea_params)

    # respond_to do |format|
    #     format.js
    # end
   
    # process_file_uploads(@idea)

    if @idea.save

      # redirect_to @idea, notice: "Ваша идея сохранена"
      # redirect_to idea_submit_path, :info, :idea_id => @idea.id, id: current_user.id
      # redirect_to submits_path(:idea_id => @idea.id)
      redirect_to idea_submit_path( @idea, :info)
    else
      render "new"
    end
  end

  def update
    @idea = Idea.find(params[:idea_id])

    # @idea.attributes = params[:idea]
      @idea.update(idea_params)

    # @person = current_user.person
    #   @person.update(person_params)
    #   render_wizard @person

    render_wizard @idea
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_idea
    #   @idea = Idea.find(params[:id])
    # end


    def idea_params
      params.require(:idea).permit(:agree, :idea_id, :title, :synopsis, :problem, :background, :solution, :links, :category_id, assets_attributes: :data, :data => :data)
       # :data)
       # [ data: [:url, :name, :content_type, :size ]] )
        # , :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
       # [ :image, :content_type, :file_name, :tempfile, :file_size, :updated_at, :_destroy])
      # params.require(:idea).permit(:title, :synopsis, :problem, :background, :solution, :links, :category_id, idea_images_attributes: [ :image, :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
    end
    # # Never trust parameters from the scary internet, only allow the white list through.
    # def idea_params
    #   params.require(:idea).permit(:id, :idea_id, :idea => [:title, :synopsis, :problem, :category_id])
      # params.require(:idea).permit(:agree, :title, :synopsis, :problem, :background, :solution, :links, :category_id, assets_attributes: :data, :data => :data)
       # :data)
       # [ data: [:url, :name, :content_type, :size ]] )
        # , :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
       # [ :image, :content_type, :file_name, :tempfile, :file_size, :updated_at, :_destroy])
      # params.require(:idea).permit(:title, :synopsis, :problem, :background, :solution, :links, :category_id, idea_images_attributes: [ :image, :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
    # end

end
