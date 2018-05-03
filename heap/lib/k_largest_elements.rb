require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
  end
  until heap.count == k
    heap.extract
  end
  heap.store
end
