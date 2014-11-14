class CommentsController < ApplicationController

  def index  
    @commentable = find_commentable  
    @comments = @commentable.comments
    # @comments = Comment.all 
  end

  def create  
    @commentable = find_commentable  
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id  

    respond_to do |format|
      if @comment.save
        format.html {redirect_to idea_path(params[:idea_id]) }
        format.js
      else
        format.html { render action: "new" }
        format.js { redirect_to idea_path(params[:idea_id]) }
      end
    end

  end 

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render :layout => false}
      format.json { head :no_content }
    end
  end


  private

    def find_commentable
      klass = [Idea].detect {|c| params["#{c.name.underscore}_id"]}
      @commentable = klass.find(params["#{klass.name.underscore}_id"])
    end

    def comment_params
      params.require(:comment).permit(:body, :idea_id)
      # (:agree, :title, :synopsis, :problem, :background, :solution, :links, :category_id, assets_attributes: :data, :data => :data)
    end
end
