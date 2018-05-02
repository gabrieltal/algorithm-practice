require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      val = @map.get(key)
      update_node!(key, val)
    else
      if count() == @max
        eject!()
      end
      val = @prc.call(key)
      @map.set(key, val)
      @store.append(key, val)

      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(key, val)
    if @store.empty?
      @store.append(key, val)
    else
      @store.remove(key)
      @store.append(key, val)
    end
  end

  def eject!
    head = @store.first
    @store.remove(head.key)
    @map.delete(head.key)
  end
end
