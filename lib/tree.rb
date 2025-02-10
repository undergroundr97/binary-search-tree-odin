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
    if root.value == nil
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
end

tree = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12])
# p tree.pretty_print
p tree.insert(13)
# p tree.root
p tree.pretty_print
p tree.del_node(7)
p tree.pretty_print
p "this is the node value: #{tree.find(12)}"
