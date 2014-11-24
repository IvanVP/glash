class CommentsController < ApplicationController
  before_action :authenticate_user!
  # , only: [:create, :destroy]
  before_action :find_commentable , only: :create

  filter_resource_access
  filter_access_to :moderate


  def index  
    # @commentable = find_commentable  
    # @comments = @commentable.comments
    @comments = Comment.all.unmoderated 
  end

  def create  
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id  

    respond_to do |format|
      if @comment.save
        format.html {redirect_to idea_path(params[:idea_id]) }
        format.js
      end
    end

  end 

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render :layout => false}
      # format.json { head :no_content }
    end
  end

  def moderate
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
    @comment.moderated = true
    @comment.moderated_at = Time.now
    @comment.moderator_id = current_user.id
    @comment.save

    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render :layout => false}
    end
    
  end

  private

    def find_commentable
      klass = [Idea].detect {|c| params["#{c.name.underscore}_id"]}
      @commentable = klass.find(params["#{klass.name.underscore}_id"])
    end

    def comment_params
      params.require(:comment).permit(:body, :idea_id)
    end
end
