class CommentsController < ApplicationController
  before_action :authenticate_user!
    def create
       @post = Post.find(params[:post_id])
       @comment = @post.comments.build(comment_params)
       @comment.user_id = current_user.id
       
      # app/views/comments/create.js.erb와 매핑
       if @comment.save
          respond_to do |format|
            format.js
          end
       else  
       end
    end
    
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        respond_to do |format|
          format.js
        end
      end
    end
    
    
    private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
