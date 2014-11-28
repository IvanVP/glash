class AssetsController < ApplicationController
  # before_action :authenticate_user!

  before_action :load_attachable, only: [:create, :index]
  # before_action :set_asset, only: [:show, :edit, :update]

  # filter_resource_access

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
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # POST /assets
  # POST /assets.json
  def create
    # @asset = @attachable.assets.new(params[:asset])
    @asset = @attachable.assets.build(asset_params)

    respond_to do |format|
      if @asset.save
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
      Rails.logger.info "From - load_ attachable -- klass: #{klass.inspect}"
      @attachable = klass.find(params["#{klass.name.underscore}_id"])
      Rails.logger.info "From - load_ attachable -- @attachable: #{@attachable.inspect}"

    end

    def asset_params
      params.require(:asset).permit(:idea_id, :data)
      # ( :idea_id, :data, :data_file_name, :data_content_type, :data_file_size)
    end

end
