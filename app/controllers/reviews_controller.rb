class ReviewsController < ApplicationController
  before_action :authenticate_user!
    def create
       @info = Info.find(params[:info_id])
       @review = @info.reviews.build(review_params)
       @review.user_id = current_user.id
       
      # app/views/reviews/create.js.erb와 매핑
       if @review.save
          respond_to do |format|
            format.js
          end
       else  
       end
    end
    
    def destroy
      @review = Review.find(params[:id])
      if @review.destroy
        respond_to do |format|
          format.js
        end
      end
    end
    
    private
    def review_params
      params.require(:review).permit(:content)
    end    
end
