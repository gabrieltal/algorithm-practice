require_relative "heap"

class Array
  def heap_sort!
    BinaryMinHeap.heapify_down(self, 0)
  end
end
