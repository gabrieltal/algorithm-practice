require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = [];
  result = [];
  count = {}
  vertices.each do |vert|
    queue.push(vert) if vert.in_edges.empty?
    count[vert] = vert.in_edges.count
  end
  p queue.count
  until queue.empty?
    u = queue.shift
    result << u
    u.out_edges.each do |edge|
      to_vert = edge.to_vertex
      count[to_vert] -= 1
      queue.push(to_vert) if count[to_vert] == 0
    end
  end
  result
end
