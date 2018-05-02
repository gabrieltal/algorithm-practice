class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev = self.prev
    next_one = self.next
    prev.next = next_one
    next_one.prev = prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new()
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @last
  end

  def empty?
    @head.val.nil?
  end

  def get(key)
    traverse = @head
    until traverse.nil? || traverse.key == key
      traverse = traverse.next
    end
    if traverse.nil?
    elsif traverse.key == key
      traverse.val
    end
  end

  def include?(key)
    traverse = @head
    until traverse.key == key || traverse.next.nil?
      traverse = traverse.next
    end
    return true if traverse.key == key
    false
  end

  def append(key, val)
    if (self.empty?)
      @head.key = key
      @head.val = val
      return @head
    end
    traverse = @head
    until traverse.next.nil?
      traverse = traverse.next
    end
    newNode = Node.new(key, val)
    traverse.next = newNode
    newNode.prev = traverse
    @last = newNode
  end

  def update(key, val)
    traverse = @head
    until traverse.key == key || traverse.next.nil?
      traverse = traverse.next
    end
    if traverse.key == key
      traverse.val = val
    end
  end

  def remove(key)
    traverse = @head
    prev = traverse
    until traverse.key == key || traverse.next.nil?
      prev = traverse
      traverse = traverse.next
    end

    if traverse == @head
      @head = traverse.next
    else
      traverse.remove()
    end
  end

  def each
    list = self
    traverse = list.first
    arr = []
    until traverse.nil?
      arr << traverse
      yield traverse
      traverse = traverse.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
