
def kth_largest(tree_node, k)
  arrayMe(tree_node, [])[-k]

end

def arrayMe(node, arr)
  return arr if node.nil?
  arrayMe(node.left, arr)
  arr.push(node)
  arrayMe(node.right, arr)
end
