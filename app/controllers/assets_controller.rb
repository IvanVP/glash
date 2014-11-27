class AssetsController < ApplicationController
  # before_action :authenticate_user!

  before_action :load_attachable, only: [:create, :index]
  # before_action :set_asset, only: [:show, :edit, :update]

  # filter_resource_access

  # GET /assets
  # GET /assets.json
  def index
    @assets = @attachable.assets
     # || []
    puts "**********************************"
    p @assets

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
  # def new
  #   @assets = @attachable.asset.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @asset }
  #   end
  # end

  # GET /assets/1/edit
  # def edit
  # end

  # POST /assets
  # POST /assets.json
  def create
    Rails.logger.info "ENTERING CREATE ASSET"
    
    Rails.logger.info "1- before @attachable: #{@attachable.inspect}"
    Rails.logger.info "1- before Params: #{params}"
    Rails.logger.info "1- before ASSET Params: #{asset_params}"
    Rails.logger.info "1- before @asset: #{@asset}"
    Rails.logger.info "1- before @asset: #{@asset.inspect}"
    Rails.logger.info "1- before @asset_params: #{asset_params}"
    @asset = @attachable.assets.build(asset_params)
    if @asset
      Rails.logger.info "Asset - builded @asset: #{@asset}"
    else
      Rails.logger.info "Asset - !!! not  builded @asset: #{@asset}"
    end


    Rails.logger.info "@attachable: #{@attachable.inspect}"
    Rails.logger.info "Params: #{params}"
    Rails.logger.info "ASSETParams: #{asset_params}"
    Rails.logger.info "@asset: #{@asset}"
    Rails.logger.info "@asset: #{@asset.inspect}"
    Rails.logger.info "@asset_params: #{asset_params}"

    respond_to do |format|
      if @asset.save
        Rails.logger.info "@asset.to_jq_upload: #{@asset.to_jq_upload.to_json}"
        format.html {
          render :json => [@asset.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@asset.to_jq_upload]}, status: :created, location: @upload }
      else
        Rails.logger.info "!!!Not saved"
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
    @attachable = @asset.attachable
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

      Rails.logger.info "From - load_ attachable --Params: #{params}"
      # Rails.logger.info "From - load_ attachable --ASSET_Params: #{asset_params}"
      # Rails.logger.info "From - load_ attachable --@asset: #{@asset}"
      # Rails.logger.info "From - load_ attachable --@asset: #{@asset.inspect}"
      # Rails.logger.info "From - load_ attachable --@asset_params: #{asset_params}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit( :idea_id, :data, :data_file_name, :data_content_type, :data_file_size)
      # (:idea_id, :data => :data)
    end

end
