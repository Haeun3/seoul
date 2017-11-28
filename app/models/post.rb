class Post < ActiveRecord::Base
    # title 검색
    searchable do
        text :title
    end
    
    self.per_page = 9
    belongs_to :user
    
    has_many :comments, dependent: :destroy
    validates :title, presence: {message: "제목을 써주세요"}
 
end
