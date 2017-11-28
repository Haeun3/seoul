class Like < ActiveRecord::Base
    #어떤 사용자가 어떤 정보를 좋아했는지 
    belongs_to :user
    belongs_to :info
    
    # has_many :courses, dependent: :destroy
end
