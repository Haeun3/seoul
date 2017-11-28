class TourManager
  def self.destination_cities
    @destination_cities ||= []
  end
  
  ################### 추가  ######################
  def self.create2DGraph(n)  #그래프 만들기
                                     #n개의 항을 가진 n개의 배열
    @graph = Array.new(n){Array.new(n)} #Array.new(3){Array.new(3)}의 결과 : [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
    @num = n
     0.upto(n - 1) do |i|
      0.upto(n - 1) do |j|
        @graph[i][j] = 0 #모두 값을 0으로
      end
    end
  end
  
  def self.print2DGraph #그래프 출력
  
  print(@graph)

  end

  def self.graph # 값이 할당되지 않은 그래프에만 값을 할당하고 싶다
    @graph ||= Array.new(@num) { Array.new(@num)}
  end


  def self.add_city( city )
    destination_cities << city #<< : 배열 끝에 city 더하기
  end

  def self.get_city( index )
    destination_cities[ index ]
  end

  def self.initialize
    @destination_cities = []
  end
  
  def self.number_of_cities
    destination_cities.size
  end

  def self.each_city
    destination_cities.each do |city|
      yield city
    end
  end
end