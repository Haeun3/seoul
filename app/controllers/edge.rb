class Edge
  attr_accessor :fromIdx
  attr_accessor :toIdx
  attr_accessor :time
  attr_accessor :distance
  

  def initialize(fromIdx, toIdx, time, distance)
    self.fromIdx = fromIdx
    self.toIdx = toIdx
    self.time = time
    self.distance = distance
  end

  def to_s
    "#{self.fromIdx}, #{self.toIdx}, #{self.time}, #{self.distance}"
  end
end