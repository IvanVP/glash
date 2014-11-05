class AssetsController < ApplicationController
  before_action :load_attachable
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
  def index
    @assets = @attachable.assets
    # @assets = Asset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets.map{|upload| upload.to_jq_upload } }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  def new

    @assets = @attachable.asset.new

    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @asset }
    # end
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @assets = @attachable.assets.create(asset_params)
    params[:asset][:data].each do |file|
      @asset = Asset.new(:asset => file)
      @asset.save
    end
    if @assets.save
      redirect_to idea_submit_path( params[:idea_id], :images, notice: "OK")
    else
      redirect_to idea_submit_path( params[:idea_id], :images, notice: "Bad #{@assets} ")
    end


    # @asset = Asset.new(asset_params)

    # respond_to do |format|
    #   if @asset.save
    #     format.html {
    #       render :json => [@asset.to_jq_upload].to_json,
    #       :content_type => 'text/html',
    #       :layout => false
    #     }
    #     format.json { render json: {files: [@asset.to_jq_upload]}, status: :created, location: @asset }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @asset.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'asset was successfully updated.' }
        format.json { rhead :no_content }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end

  private

    # def load_attachable
    #   resource, id = request.path.split('/')[1,2]
    #   @attachable = resource.singularize.classify.constantize.find(id)
    # end

    def load_attachable
      klass = [Idea].detect {|c| params["#{c.name.underscore}_id"]}
      @attachable = klass.find(params["#{klass.name.underscore}_id"])
      puts '&&&&&&&&&&&&&&&&&&&&&&************'
      puts @attachable
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = @attachable.assets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit( :idea_id, :data => [:data_file_name, :data_content_type, :data_file_size])
      # ( :idea_id, :data, :data_file_name, :data_content_type, :data_file_size)
      # 
      # (:data, :data_file_name, :data_content_type, :data_file_size, :idea_id, :data => :data)
    end

    # :data_file_name, :data_content_type, :data_file_size, :attachable_id, :attachable_type
  # def show
  #   asset = Asset.find(params[:id])
  #   # do security check here
  #   send_file asset.data.path, :type => asset.data_content_type
  # end
end
