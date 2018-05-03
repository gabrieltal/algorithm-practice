class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    @store = []
    @count = 0
  end

  def count
    @count
  end

  def extract
    @count -= 1
    @store[0], @store[-1] = @store[-1], @store[0]
    el = @store.pop()
    BinaryMinHeap.heapify_down(@store, 0)
    el
  end

  def peek
    @store.first
  end

  def push(val)
    @count += 1
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @count)
  end

  public
  def self.child_indices(len, parent_index)
    left = (2 * parent_index+1)
    right = (2 * parent_index + 2)
    children = []
    children.push(left) if left < len
    children.push(right) if right < len
    return children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    if (child_index.even?)
      (child_index / 2) - 1
    else
      child_index / 2
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    array.each_index do |idx|
      child = BinaryMinHeap.child_indices(len, idx)
      next if child.any? { |e| e.nil? } || child.empty?
      left, right = child
      if !right.nil?
        left, right = right, left if (prc.call(array[left], array[right]) == 1)
      end
      if prc.call(array[idx], array[left]) == 1
        array[idx], array[left] = array[left], array[idx]
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    (len-1).downto(1) do |idx|
      parent = BinaryMinHeap.parent_index(idx)
      if prc.call(array[idx], array[parent]) == -1
        array[idx], array[parent] = array[parent], array[idx]
      end
    end
    array
  end
end
