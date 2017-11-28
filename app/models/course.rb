class Course < ActiveRecord::Base
    #어떤 사용자가 어떤 정보를 코스짜달라 했는지
    belongs_to :user
    belongs_to :info
    belongs_to :like
end
