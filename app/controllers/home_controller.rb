require ('open-uri')
require ('nokogiri')
require ('json')
class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index
  def login
    
  end
  
  def index
    
    # 인기순으로 축제 데이터 가져오기
    indoc1 = JSON.parse open('http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=18&arrange=P&eventStartDate=20171130&eventEndDate=20171231&pageNo=1&MobileOS=ETC&MobileApp=TestApp&_type=json').read
    
    # puts JSON.pretty_generate(indoc1)

    @festival1 = indoc1
 
  end
  
  def mypage
    @mypost = Post.where(user_id: current_user.id)
  end
  def myfood
    @mylikes = Like.where(user_id: current_user.id)
    @infos = Info.all
  end
  def myplace
    @mylikes = Like.where(user_id: current_user.id)
    @infos = Info.all
  end
  def mysleep
    @mylikes = Like.where(user_id: current_user.id)
    @infos = Info.all
  end
  
  def course
  end


end
