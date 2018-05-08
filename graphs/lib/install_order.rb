# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'graph'
require 'topological_sort'

def install_order(arr)
  vertices = {}
  flat = arr.flatten.uniq
  max = flat.max
  min = flat.min
  nodes = (min..max)
  nodes.each do |el|
    vertices[el] = Vertex.new(el);
  end
  arr.each do |el|
    Edge.new(vertices[el.first], vertices[el.last])
  end
  a = topological_sort(vertices.values)
  a.map { |e| e.value }
end
