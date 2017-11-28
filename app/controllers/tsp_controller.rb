require ('open-uri')
require ('nokogiri')
require ('json')
require ('singleton')

require 'tour_manager' #수정함 & 컨트롤러 빼냄

class TspController < ApplicationController
  # 모두 순회
  # def iterateAll
  #   @key = "SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D"
  #   @startX = 127.0433650
  #   @startY = 37.6489650
  #   @endX = 127.0578430
  #   @endY = 37.5973190
  #   @doc = Nokogiri::XML(open("http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoByBusNSub?ServiceKey=#{@key}&startX=#{@startX}&startY=#{@startY}&endX=#{@endX}&endY=#{@endY}"))
    
  #   itemLists = @doc.root.xpath("msgBody/itemList")
  
  #   routei = 0
  #   routeNum = itemLists.count
  #   while routei < routeNum  do
  #     itemList = itemLists[routei]
  #     paths = itemList.xpath("pathList")
      
  #     time = itemList.at_xpath("time").content
      
     
  #     puts("경로 : #{routei}")
  #     puts("시간 : #{time}")
      
  #     # 거리
  #     distance = itemList.at_xpath("distance").content
  #     puts("거리 : #{distance}")
      
  #     i = 0
  #     num = paths.count
  #     while i < num  do
  #       start = paths[i].at_xpath("fname").content
  #       puts("시작 : #{start}")
        
  #       bus = paths[i].at_xpath("routeNm").content
  #       puts("버스 : #{bus}")
        
  #       arrive = paths[i].at_xpath("tname").content
  #       puts("도착 : #{arrive}")
  #       puts("환승")
  #       i+=1
  #     end
      
  #     routei+=1
  #   end
  
  # end
  
  def addNode(dbid, name, idx, x, y)
    city = City.new(dbid, name, idx, x, y)
    TourManager.add_city(city)
  end
  
  def queryApi()
    @key = "SDnLBwvmF457HIcO1IHLK7wijZvagNwmottEEVlfMuYrlKLiBUtsxo7heZC5ITVe0NtXFmMV96jYcMqJcMBvFQ%3D%3D"
    @infos = Info.where(category: "place")
    @infos1 = Info.where(category: "place")
    @infos.each do |info|
      @infos1.each do |info1|
        if info.id < info1.id
          @route = Route.new
          @route.start = info1.id
          @startX = info.mapx
          @startY = info.mapy
          @endX = info1.mapx
          @endY = info1.mapy 
          @route.end = info.id
          requestPath = "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoByBusNSub?ServiceKey=#{@key}&startX=#{@startX}&startY=#{@startY}&endX=#{@endX}&endY=#{@endY}"
          @doc = Nokogiri::XML(open(requestPath))
          itemLists = @doc.root.xpath("msgBody/itemList")
          maxItemList = itemLists.min_by{ |itemList| itemList.at_xpath("time").content }
          itemList = maxItemList
          if itemList != nil
            @route.time = itemList.at_xpath("time").content
          else
            @route.time = 20000000
          end
          @route.save
        end
      end
    end
    
    
    # requestPath = "http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoByBusNSub?ServiceKey=#{@key}&startX=#{@startX}&startY=#{@startY}&endX=#{@endX}&endY=#{@endY}"
    
    # puts("Start request : " + requestPath)
    # @doc = Nokogiri::XML(open(requestPath))
    
    # puts("Data received!!!!!!!!!!!!!!!!!!")
    
    # itemLists = @doc.root.xpath("msgBody/itemList")
  
    # # 최소 시간의 경로
    # maxItemList = itemLists.min_by{ |itemList| itemList.at_xpath("time").content }
   
    # itemList = maxItemList
    
    # if itemList != nil
    #   paths = itemList.xpath("pathList") # 두 장소 사이 - 버스/지하철타고 가는 법
    #   puts("경로: #{paths}" ) 
      
    #   time = itemList.at_xpath("time").content
    #   puts("시간 : #{time}")
      
    #   distance = itemList.at_xpath("distance").content
    #   puts("거리 : #{distance}")
    # else
    #   time = 20000000
    # end  
    
    # from.dbid
    # to.dbid
    # time
    redirect_to '/home/index'
  end
  
  def addEdge(from, to, time)
    graph = TourManager.graph
    
    
    graph[from.idx][to.idx] = time.to_i
    graph[to.idx][from.idx] = time.to_i
  end
  
  def saveDB
  
    #TourManager.create2DGraph(45) #[n개항] n개인 그래프 만들기 지금은 10개

    @mycourses = Course.where(user_id: current_user.id)
    @infos = Info.all
    
    
    @cities = []
    # 모든 장소 가져오기
    idx = 0;
    @infos.each do |info| 
		 @mycourses.each do |course| 
		  if (course.info_id == info.id)
		    @mapx = info.mapx
		    @mapy = info.mapy
		    @title = info.title
		    @id = info.id
		    
		    city = City.new(@id, @title, idx, @mapx, @mapy)
		    
		    @cities << city
		    
		    addNode(@id, @title, idx, @mapx, @mapy)
		    
		    idx+=1
		    puts ("name : #{@title} info_id : #{info.id} #{@mapx} #{@mapy}")
		  end
		 end
		end
    
    graph = TourManager.graph
    
    i = 0
    num = TourManager.destination_cities.count
    while i < num  do
      j = i + 1
      while j < num  do
        from = TourManager.destination_cities[i]
        to = TourManager.destination_cities[j]

        puts("############################ #{fname}  #{tname}  ############################")
        queryApi(from, to)
      
        j+=1
      end
      i+=1
    end
  
  end
  
  
  def routing
  
  # db 에서 course  개수 가져오기
  
   
   TourManager.create2DGraph(45) #[n개항] n개인 그래프 만들기 지금은 10개

    @mycourses = Course.where(user_id: current_user.id)
    @infos = Info.all
    
    TourManager.initialize()
    
    # course 장소 가져오기
    idx = 0;
    @infos.each do |info| 
		 @mycourses.each do |course| 
		  if (course.info_id == info.id)
		    @mapx = info.mapx
		    @mapy = info.mapy
		    @title = info.title
		    @id = info.id
		    
		    addNode(@id, @title, idx, @mapx, @mapy)
		    
		    idx+=1
		    puts ("name : #{@title} info_id : #{info.id} #{@mapx} #{@mapy}")
		  end
		 end
		end
    
    
    i = 0
    num = TourManager.destination_cities.count
    while i < num  do
      j = i + 1
      while j < num  do
        from = TourManager.destination_cities[i]
        to = TourManager.destination_cities[j]

        # db에서 time을 가져오기
        # time = 9
        @test = from.dbid
        @test2 = to.dbid
        @routes = Route.where(start: from.dbid)
        @routes.each do |route|
          if route.end == to.dbid
            @time = route.time
            break
          end
        end
        puts("야야야야 #{@test} #{@test2} #{@time}")
        addEdge(from, to, @time)
      
        j+=1
      end
      i+=1
    end
  
    TourManager.print2DGraph
    

  
    puts ("print2DGraph")
    TourManager.print2DGraph
  
    # Initialize population
    population = Population.new(1000, true)
    puts "Initial distance: #{population.fittest.distance}"
    
    # Evolve population
    population = GA.evolve_population(population)
    population = GA.evolve_population(population)
    100.times do
      population = GA.evolve_population(population)
    end
    
    puts "Finished"
    puts "Final distance: #{population.fittest.distance}"
    puts "Solution:"
    puts population.fittest.to_s
    
    puts population.fittest.tour.count
    
    population.fittest.tour.each { |city| puts city.to_s }
    @result = population.fittest.to_s.split('|')
  
    Course.destroy_all
  end
end
