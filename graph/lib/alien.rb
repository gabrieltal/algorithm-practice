def topological_sort(vertices)
  queue = [];
  result = [];
  count = {}
  vertices.each do |vert|
    queue.push(vert) if vert.in_edges.empty?
    count[vert] = vert.in_edges.count
  end
  until queue.empty?
    u = queue.shift
    result << u
    u.out_edges.each do |edge|
      to_vert = edge.to_vertex
      count[to_vert] -= 1
      queue.push(to_vert) if count[to_vert] == 0
    end
  end

  if (result.length != vertices.length)
    return []
  end
  result
end

class Vertex
  attr_accessor :value, :in_edges, :out_edges
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    to_vertex.in_edges.push(self)
    from_vertex.out_edges.push(self)
    @cost = cost
  end

  def destroy!
    @to_vertex.in_edges.delete(self)
    @from_vertex.out_edges.delete(self)
    self.from_vertex = nil
    self.to_vertex = nil
  end
end

def install_order(arr)
  vertices = {}
  nodes = arr.flatten.uniq
  nodes.each do |el|
    vertices[el] = Vertex.new(el);
  end
  arr.each do |el|
    Edge.new(vertices[el.first], vertices[el.last])
  end
  a = topological_sort(vertices.values)
  a.map { |e| e.value }
end

def alien(words)
  result = []
  words.each_with_index do |word, idx|
    next if idx+1 == words.length
    word.chars.each_with_index do |c, j|
      if c != words[idx+1][j]
        result << [c, words[idx+1][j]]
        break;
      end
    end
  end
  result
end

words = ["baa", "abcd", "abca", "cab", "cad"]
arr = alien(words)
p install_order(arr)
