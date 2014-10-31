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
    @idea.assets.build
    # 3.times {@idea.assets.build}
  end

  def edit
    # 3.times {@idea.assets.build}
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id

    respond_to do |format|
        format.js
    end
   
    # process_file_uploads(@idea)

    if @idea.save
      


      # puts "***********************"
      # puts
      # puts
      # puts
      # @idea.assets.each {|i| puts i}
      # puts
      # puts "***********************"

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

  # protected

  # def process_file_uploads(idea)
  #     i = 0
  #     while params[:asset]['file_'+i.to_s] != "" && !params[:asset]['file_'+i.to_s].nil?
  #         idea.assets.build(:data => params[:asset]['file_'+i.to_s])
  #         i += 1
  #     end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :synopsis, :problem, :background, :solution, :links, :category_id, assets_attributes: :data, :data => :data)
       # :data)
       # [ data: [:url, :name, :content_type, :size ]] )
        # , :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
       # [ :image, :content_type, :file_name, :tempfile, :file_size, :updated_at, :_destroy])
      # params.require(:idea).permit(:title, :synopsis, :problem, :background, :solution, :links, :category_id, idea_images_attributes: [ :image, :image_content_type, :image_file_name, :tempfile, :image_file_size, :image_updated_at, :_destroy])
    end


end


# "assets_attributes"=>
#   {"0"=>
#     {"image"=>#<ActionDispatch::Http::UploadedFile:0x00000009cc8b08
#         @tempfile=#<Tempfile:/tmp/RackMultipart20141030-7037-1iu4i1b>
#         , @original_filename="partop.jpg", 
#         @content_type="image/jpeg", 
#         @headers="Content-Disposition: form-data; 
#          name=\"idea[assets_attributes][0][image]\";
           # filename=\"partop.jpg\"\r\nContent-Type: image/jpeg\r\n">}