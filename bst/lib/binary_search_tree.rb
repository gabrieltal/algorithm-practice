# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    else
      rec_insert(@root, value)
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    if value == tree_node.value
      return tree_node
    elsif value <= tree_node.value
      find(value, tree_node.left)
    elsif value > tree_node.value
      find(value, tree_node.right)
    end
  end

  def delete(value)
    return @root = nil if @root.value == value
    parent = get_parent(value, @root)
    if !parent.left.nil? && parent.left.value == value
      if has_no_children?(parent.left)
        parent.left = nil
      elsif !parent.left.left.nil? && parent.left.right.nil?
        parent.left = parent.left.left
      elsif !parent.left.right.nil? && parent.left.left.nil?
        parent.left = parent.left.right
      else
        max = maximum(parent.left.left)
        delete(max.value)
        target = parent.left
        parent.left = max
        max.left = target.left
        max.right = target.right
      end
    elsif !parent.right.nil? && parent.right.value == value
      if has_no_children?(parent.right)
        parent.right = nil
      elsif !parent.right.left.nil? && parent.right.right.nil?
        parent.right = parent.right.left
      elsif !parent.right.right.nil? && parent.right.left.nil?
        parent.right = parent.right.right
      else
        max = maximum(parent.right.left)
        delete(max.value)
        target = parent.right
        parent.right = max
        max.left = target.left
        max.right = target.right
      end
    else
      return nil
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    cursor = tree_node
    until cursor.right.nil?
      cursor = cursor.right
    end
    cursor
  end

  def depth(tree_node = @root)
    return 0 if has_no_children?(@root)
    if (tree_node.nil?)
      return -1
    end
    left = depth(tree_node.left)
    right = depth(tree_node.right)
    left > right ? left+1 : right+1
  end

  def is_balanced?(tree_node = @root)
    return true if @root.nil? || has_no_children?(@root)
    left = @root.left
    right = @root.right
    until left.nil? && right.nil?
      if (depth(left.left) != depth(right.right))
        return false
      end
      left = left.left
      right = right.right
    end
    true
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr)
  end


  private
  def rec_insert(root, value)
    if root.nil?
      root = BSTNode.new(value)
    elsif (value <= root.value)
      root.left = rec_insert(root.left, value)
    else
      root.right = rec_insert(root.right, value)
    end
    return root
  end

  def get_parent(value, node=@root)
    return nil if node.nil?
    if node.left.value == value
      return node
    elsif node.right.value == value
      return node
    elsif value <= node.value
      get_parent(value, node.left)
    elsif value > node.value
      get_parent(value, node.right)
    else
      return nil
    end
  end

  def left_most(root=@root)
    count = 0
    left = @root.left
    until left.nil?
      left = left.left
      count += 1
    end
    return count
  end

  def has_no_children?(node)
    node.left.nil? && node.right.nil?
  end
end
