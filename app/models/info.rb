class Info < ActiveRecord::Base
    Info.per_page = 27
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    
    has_many :courses, dependent: :destroy
    has_many :coursed_users, through: :courses, source: :user
    
    has_many :reviews, dependent: :destroy
    
end
