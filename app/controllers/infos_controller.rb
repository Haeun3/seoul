require ('open-uri')
require ('nokogiri')
require ('json')
class InfosController < ApplicationController
    # before_action :authenticate_user!
    def create
      #데이터를 실제 DB에 저장
      #contentTypeId = 축제 : 15 /  관광지 : 12 / 음식점 : 39 / 숙박 : 32 /
      @place_contentid = 12
      @food_contentid = 39
      @sleep_contentid = 32
      #json
      @place_doc = JSON.parse open('http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=45&arrange=P&contentTypeId=12&pageNo=1&MobileOS=ETC&MobileApp=TestApp&_type=json').read
      @food_doc = JSON.parse open('http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=45&arrange=P&contentTypeId=39&pageNo=1&MobileOS=ETC&MobileApp=TestApp&_type=json').read
      @sleep_doc = JSON.parse open('http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=45&arrange=P&contentTypeId=32&pageNo=1&MobileOS=ETC&MobileApp=TestApp&_type=json').read


    
      $i = 0
      $num = 45
      while $i < $num  do
        #place data
        @name = @place_doc['response']['body']['items']['item'][$i]['contentid']
        @detail = JSON.parse open("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=10&contentId=#{@name}&pageNo=1&contentTypeId=#{@place_contentid}&introYN=Y&MobileOS=ETC&MobileApp=TestApp&_type=json").read
        @explain = JSON.parse open("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&numOfRows=10&contentId=#{@name}&pageNo=1&defaultYN=Y&overviewYN=Y&addrinfoYN=Y&MobileOS=ETC&MobileApp=TestApp&_type=json").read
        
        @info = Info.new
        #1
        @info.img = @place_doc['response']['body']['items']['item'][$i]['firstimage'] #사진
        @info.title = @place_doc['response']['body']['items']['item'][$i]['title'] #이름
        @info.mapx = @place_doc['response']['body']['items']['item'][$i]['mapx'] #mapx
        @info.mapy = @place_doc['response']['body']['items']['item'][$i]['mapy'] #mapy
        #2
        @info.phone = @detail['response']['body']['items']['item']['infocenter'] #전화번호
        @info.parking = @detail['response']['body']['items']['item']['parking'] #주차
        @info.restdate = @detail['response']['body']['items']['item']['restdate'] #쉬는날
        # @info.useseason = @detail['response']['body']['items']['item']['useseason'] #이용시기
        @info.usetime = @detail['response']['body']['items']['item']['usetime'] #이용시간
        #3
        @info.addr = @explain['response']['body']['items']['item']['addr1'] #주소
        @info.content = @explain['response']['body']['items']['item']['overview'] #설명
        # @info.homepage = @explain['response']['body']['items']['item']['homepage'] #홈페이지
      
        @info.category = "place"
        @info.save
        
        #food data
        @name = @food_doc['response']['body']['items']['item'][$i]['contentid']
        @detail = JSON.parse open("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=10&contentId=#{@name}&pageNo=1&contentTypeId=#{@food_contentid}&introYN=Y&MobileOS=ETC&MobileApp=TestApp&_type=json").read
        @explain = JSON.parse open("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&numOfRows=10&contentId=#{@name}&pageNo=1&defaultYN=Y&overviewYN=Y&addrinfoYN=Y&MobileOS=ETC&MobileApp=TestApp&_type=json").read

        @info = Info.new
        #1
        @info.img = @food_doc['response']['body']['items']['item'][$i]['firstimage']
        @info.title = @food_doc['response']['body']['items']['item'][$i]['title'] 
        #2
        @info.phone = @detail['response']['body']['items']['item']['infocenterfood'] #전화번호
        @info.parking = @detail['response']['body']['items']['item']['parkingfood'] #주차시설
        @info.firstmenu = @detail['response']['body']['items']['item']['firstmenu'] #대표메뉴
        @info.packing = @detail['response']['body']['items']['item']['packing'] #포장 가능
        @info.treatmenu = @detail['response']['body']['items']['item']['treatmenu'] #취급메뉴
        @info.usetime = @detail['response']['body']['items']['item']['opentimefood'] #영업시간
        @info.restdate = @detail['response']['body']['items']['item']['restdatefood'] #쉬는날
        @info.reservation = @detail['response']['body']['items']['item']['reservationfood'] #예약안내
        
        #3
        @info.addr = @explain['response']['body']['items']['item']['addr1'] #주소
        @info.content = @explain['response']['body']['items']['item']['overview'] #설명
        # @info.homepage = @explain['response']['body']['items']['item']['homepage'] #홈페이지
        
        @info.category = "food"
        @info.save
        
        #sleep_data
        @name = @sleep_doc['response']['body']['items']['item'][$i]['contentid']
        @detail = JSON.parse open("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&areaCode=1&numOfRows=10&contentId=#{@name}&pageNo=1&contentTypeId=#{@sleep_contentid}&introYN=Y&MobileOS=ETC&MobileApp=TestApp&_type=json").read
        @explain = JSON.parse open("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D&numOfRows=10&contentId=#{@name}&pageNo=1&defaultYN=Y&overviewYN=Y&addrinfoYN=Y&MobileOS=ETC&MobileApp=TestApp&_type=json").read

        @info = Info.new
        #1
        @info.img = @sleep_doc['response']['body']['items']['item'][$i]['firstimage']
        @info.title = @sleep_doc['response']['body']['items']['item'][$i]['title'] 
        # 2
        @info.phone = @detail['response']['body']['items']['item']['infocenterlodging']
        @info.parking = @detail['response']['body']['items']['item']['parkinglodging']
        @info.checkintime = @detail['response']['body']['items']['item']['checkintime']
        @info.checkouttime = @detail['response']['body']['items']['item']['checkouttime']
        @info.pickup = @detail['response']['body']['items']['item']['pickup']
        @info.reservation = @detail['response']['body']['items']['item']['reservationlodging']
        #3
        @info.addr = @explain['response']['body']['items']['item']['addr1'] #주소
        @info.content = @explain['response']['body']['items']['item']['overview'] #설명
        # @info.homepage = @explain['response']['body']['items']['item']['homepage'] #홈페이지
        
        @info.category = "sleep"
        @info.save
        
        $i +=1
      end
      redirect_to "/infos/show/#{@info.id}"
    end
    
    def board
    
    end
    
    def show
      @info = Info.find(params[:info_id])
    end
    
    def place_show
    #장소 view
      # @infos = Info.all
      @infos = Info.paginate(:page => params[:page])
    end
  
    def food_show
    #식당 view
       @infos = Info.paginate(:page => params[:page])
    end
  
    def sleep_show
     #숙박 view
      @infos = Info.paginate(:page => params[:page])
    end
    
    def place_info_show
      #장소 상세보기
      @info = Info.find(params[:info_id])
    end
    def food_info_show
      #음식점 상세보기
      @info = Info.find(params[:info_id])
    end
    def sleep_info_show
      #숙박 상세보기
      @info = Info.find(params[:info_id])
    end
    
   
end
