class City
  attr_accessor :dbid
  attr_accessor :name
  attr_accessor :idx
  attr_accessor :x
  attr_accessor :y
  attr_accessor :time

  def initialize(dbid, name, idx, x, y) #초기화
    self.dbid = dbid
    self.name = name
    self.idx = idx
    self.x = x
    self.y = y
  end

  def distance_to(city) #거리
    
    @graph = TourManager.graph
    
    thisIdx = self.idx
    otherIdx = city.idx
    gap = @graph[thisIdx][otherIdx]
    time = gap.to_i
    time
  end

  def to_s
    "#{self.dbid}, #{self.name}, #{self.idx}, #{self.x}, #{self.y}"
  end
end