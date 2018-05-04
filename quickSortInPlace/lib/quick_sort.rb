class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot = array[0]
    left = []
    right = []
    1.upto(array.length) do |i|
      if array[i] < pivot
        left.push(array[i])
      else
        right.push(array[i])
      end
    end
    left + [pivot] + right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new{|x, y| x <=> y}
    return array if length <= 1
    pivot = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot-start, &prc)
    QuickSort.sort2!(array, pivot+1, length - pivot - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|x, y| x <=> y}
    barrier = start
    barrier.upto(length+start-1) do |i|
      next if barrier == i
      if (prc.call(array[start], array[i]) == 1)
        array[barrier+1], array[i] = array[i], array[barrier+1]
        barrier += 1
      end
    end
    array[barrier], array[start] = array[start], array[barrier]
    barrier
  end
end
