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
    if @comment.save  
      flash[:notice] = "Successfully saved comment."
      # render :json => nil, :content_type => 'text/html', :layout => false
      redirect_to idea_path(params[:idea_id])  
    else  
      render :action => 'new'  
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
