require_relative "heap"

class Array
  def heap_sort!
    arr = self
    (0).upto(arr.length) do |i|
      arr = BinaryMinHeap.heapify_down(arr, 0)
    end
    arr
  end
end
