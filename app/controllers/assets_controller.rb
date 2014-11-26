class AssetsController < ApplicationController
  before_action :authenticate_user!

  before_action :load_attachable, except: :destroy
  before_action :set_asset, only: [:show, :edit, :update]

  filter_resource_access

  # GET /assets
  # GET /assets.json
  def index
    @assets = @attachable.assets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets.map{|upload| upload.to_jq_upload } }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  # def show

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @asset }
  #   end
  # end

  # GET /assets/new
  def new
    @assets = @attachable.asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/1/edit
  # def edit
  # end

  # POST /assets
  # POST /assets.json
  def create
    @asset = @attachable.assets.new(asset_params)
    Rails.logger.info "Params: #{params}"
    Rails.logger.info "@asset: #{@asset}"

    respond_to do |format|
      if @asset.save(asset_params)
        Rails.logger.info "@asset.to_jq_upload: #{@asset.to_jq_upload.to_json}"
        format.html {
          render :json => [@asset.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@asset.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  # def update
  #   respond_to do |format|
  #     if @asset.update(asset_params)
  #       format.html { redirect_to @asset, notice: 'asset was successfully updated.' }
  #       format.json { rhead :no_content }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @asset.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render :layout => false}
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
      Rails.logger.info "klass: #{klass}"
      @attachable = klass.find(params["#{klass.name.underscore}_id"])
      Rails.logger.info "@attachable: #{@attachable}"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = @attachable.assets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit( :idea_id, :data)
      # ( :idea_id, :data, :data_file_name, :data_content_type, :data_file_size)
    end

end
