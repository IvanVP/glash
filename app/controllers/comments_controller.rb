class CommentsController < ApplicationController

  private

    # def load_attachable
    #   resource, id = request.path.split('/')[1,2]
    #   @attachable = resource.singularize.classify.constantize.find(id)
    # end

    def load_commentable
      klass = [Idea].detect {|c| params["#{c.name.underscore}_id"]}
      @commentable = klass.find(params["#{klass.name.underscore}_id"])
    end
end
