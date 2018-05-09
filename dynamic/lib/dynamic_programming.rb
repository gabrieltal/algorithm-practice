class DynamicProgramming

  def initialize
    @blair_cache = {}
    @f_cache = {1 => [[1]], 2=>[[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]]}
    @frog_cache = {1 => [[1]], 2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]}
    @mazeSoln = []
    @sack = {}
  end

  def blair_nums(n)
    if n <= 2
      @blair_cache[n] = n
    end
    if @blair_cache[n]
      return @blair_cache[n]
    else
      curr = blair_nums(n-1) + blair_nums(n-2)
      @blair_cache[n] = curr + (2 * ((n-1) - 1) + 1)
      return @blair_cache[n]
    end
  end

  def frog_hops_bottom_up(n)
    return nil if n > 999
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    frog_hops_top_down_helper(1)
    frog_cache = {1 => [[1]], 2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]}
    return frog_cache if n <= 3
    4.upto(n) do |i|
      arr1 = frog_cache[i-1].map {|sn| sn + [1]}
      arr2 = frog_cache[i-2].map{ |sn| sn + [2]}
      arr3 = frog_cache[i-3].map{ |sn| sn + [3]}
      frog_cache[i] = arr1 + arr2 + arr3
    end
    frog_cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    frog_hops_top_down_helper(1)
    cache1 = frog_hops_top_down(n-1).map{|arr| arr + [1]}
    cache2 = frog_hops_top_down(n-2).map{|arr| arr + [2]}
    cache3 = frog_hops_top_down(n-3).map{|arr| arr + [3]}
    @frog_cache[n] = cache1 + cache2 + cache3
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    #Whyyyyyyyyyyyyyyyyyyyyyyyy DO I NEED THIS????????????????????????????
  end

  def super_frog_hops(n, k)
   return [[1]*n] if k == 1
   k = n if k > n
   return @f_cache[n] if @f_cache[n]
   cache = []
   n.downto(2) do |idx|
     if k >= n-idx+1
      cache += super_frog_hops(idx-1,k).map {|arr| [n-idx+1] + arr}
      cache += super_frog_hops(idx-1, k).map{|arr| arr + [n-idx+1]}
    end
   end
   @f_cache[n] = cache.uniq
   @f_cache[n]
  end

  def super_help(n)

  end

  def knapsack(weights, values, capacity)
    0.upto(weights.length-1) do |i|
      return values[i] if weights[i] == capacity
    end
    0
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
    @mazeSoln << start_pos
    return @mazeSoln if start_pos == end_pos
    nextX = end_pos[0] > start_pos[0] ? 1 : -1
    nextY = end_pos[1] > start_pos[1] ? 1 : -1
    if maze[nextX+start_pos[0]][start_pos[1]] == " " || maze[nextX + start_pos[0]][start_pos[1]] == 'F'
      maze_solver(maze, [nextX + start_pos[0], start_pos[1]], end_pos)
    elsif maze[start_pos[0]][nextY+start_pos[1]] == " " || maze[start_pos[0]][nextY+start_pos[1]] == 'F'
      maze_solver(maze, [start_pos[0], start_pos[1] + nextY], end_pos)
    end
  end
end
