class User < ActiveRecord::Base
  
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :infos, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
                 
   #좋아요
  has_many :likes
  has_many :liked_infos, through: :likes, source: :info
  #likes를 통해서 이 user가 좋아하는 정보를 모두 가져와라
  
  #좋아요기능
  def is_like?(info) #좋아요를 했다면 true/ 아니라면 false
    Like.find_by(user_id: self.id, info_id: info.id).present?
  end
  
  
  #코스짜기
  has_many :courses
  has_many :coursed_infos, through: :courses, source: :info
  #courses를 통해서 이 user가 좋아하는 정보를 모두 가져와라
  
  #좋아요기능
  def is_course?(info) #좋아요를 했다면 true/ 아니라면 false
    Course.find_by(user_id: self.id, info_id: info.id).present?
  end
  
end
