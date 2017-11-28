class LikesController < ApplicationController
    
    #좋아요를 클릭하거나 좋아요 취소를 클릭했을 때
    def like_toggle
        like = Like.find_by(user_id: current_user.id,
                            info_id: params[:info_id])
        if like.nil? #없으면 좋아요
            Like.create(user_id: current_user.id,
                        info_id: params[:info_id])
        else #있으면 좋아요 취소
            like.destroy
        end
        redirect_to :back
    end
end
