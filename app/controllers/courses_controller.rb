
class CoursesController < ApplicationController
     #좋아요를 클릭하거나 좋아요 취소를 클릭했을 때
    def course_toggle
        course = Course.find_by(user_id: current_user.id,
                            info_id: params[:info_id])
        if course.nil? #없으면 좋아요
            Course.create(user_id: current_user.id,
                        info_id: params[:info_id])
        else #있으면 좋아요 취소
            course.destroy
        end
        redirect_to :back
    end
    
    def destroy_all
        course = Course.all
        course.destroy
    end
end
