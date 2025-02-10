require_relative 'node'
class Tree 
  attr_accessor :root
  def initialize (array)
    @array = array
    @root = build_tree
  end

  def build_tree
    to_work = @array.sort.uniq.dup
     start = 0
     last = to_work.size 
    mid = (start+last) / 2
    # p "this is start #{start}, this is last #{last}, this is mid #{mid}"
    root = Node.new(to_work[mid])
    root.left = recursive_tree(to_work, start, mid - 1)
    root.right = recursive_tree(to_work, mid + 1, last)
    root
  end

  def recursive_tree(array, start, last)
    array
    if start > last
      return nil
    end
  # p start, last, mid
    mid = (start + last) / 2
    root = Node.new(array[mid])
    #  "this is start: #{start}, this is last #{last}, this is mid #{mid}"
    root.left = recursive_tree(array, start, mid - 1)
    root.right = recursive_tree(array, mid + 1, last)
    root
  end
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  def insert(root = @root, value)
    p root
    if root == nil
      return Node.new(value)
    end
    if (root == value)
      return root
    end
    if (value < root.value) 
      root.left = insert(root.left, value)
    elsif (value > root.value)
      root.right = insert(root.right, value)
    end
    return root
  end
  def del_node (root = @root, value)
    if root == nil
      return root
    end
    if root.value > value
      root.left = del_node(root.left, value)
    elsif root.value < value 
      root.right = del_node(root.right, value)
    else
      if root.left == nil
        return root.right
      end
      if root.right == nil
        return root.left
      end
      current_node = sucessor(root)
      root.value = current_node.value
      root.right = del_node(root.right, current_node.value)
    end
    return root
  end
  def sucessor(current_node)
    current_node = current_node.right
    while (current_node != nil && current_node.left != nil)
      current_node = current_node.left
    end
    current_node
  end
  def find(root = @root, value)
    if root.value == value
      return root
    end 

    if root.value > value
      root.left = find(root.left, value)
    elsif root.value < value
      root.right = find(root.right, value)
    end
  end
  def level_order(root = @root, array = [], &block )
    
    visited = [root]
   
    final_arr = []
    final_arr << root.value
    while !visited.empty?
      current_node = visited.shift
      if current_node.value == nil
        return
      end
      p "this is current node: #{current_node.value}"
      if(current_node.left != nil)
        final_arr << current_node.left.value
        visited << current_node.left
      end
      if(current_node.right != nil)
        final_arr << current_node.right.value
        visited << current_node.right
      end
      visited.drop(1)
      # p final_arr
    end
    puts final_arr.join(',')
    # p visited
    # array_holder = array
    # current_node = root
    # array_holder << root.value if !array_holder.include?(root.value)
    # if current_node.left != nil
    #   array_holder << root.left.value if !array_holder.include?(root.left.value)
    # end
    # if current_node.right != nil
    #   array_holder << root.right.value if !array_holder.include?(root.right.value)
    # end
    # current_node = current_node.left if array_holder.include?(root.left.value)
    # p array_holder
    
    # p current_node
    # p array_holder
  end

end

# tree = Tree.new(Array.new(21) {rand(1..50)})
tree = Tree.new([1,2,3,4,5,6,7,8,10])
# p tree.pretty_print
# p tree.root
p tree.pretty_print
p tree.del_node(7)
# p tree.insert(13)
p tree.pretty_print
# p tree.find(3)
# p "this is the node value: #{tree.find(12)}"
p tree.level_order