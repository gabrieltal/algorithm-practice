require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      resize!
    end
    @count += 1
    self[key].push(key.hash)
  end

  def include?(key)
    return true if self[key].include?(key.hash)
    false
  end

  def remove(key)
    @count -= 1
    self[key].delete(key.hash)
  end

  private

  def [](num)
    @store[num.hash % num_buckets()]
  end

  def num_buckets
    @store.length
  end

  def resize!
    size = num_buckets() * 2
    new_store = Array.new(size) { Array.new }
    @store.each do |arr|
      arr.each do |el|
        new_store[el.hash % size].push(el.hash)
      end
    end
    @store = new_store
  end
end
