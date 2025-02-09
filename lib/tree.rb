require_relative 'node'
class Tree 
  attr_accessor :root
  def initialize (array)
    @array = array
    @root = build_tree
  end

  def build_tree
    to_work = @array.uniq.sort.dup
     start = to_work[0]
     last = to_work[-1]
    mid = (start+last) / 2
    p "this is start #{start}, this is last #{last}, this is mid #{mid}"
    root = Node.new(mid)
    root.left = recursive_tree(to_work, start, mid - 1)
    root.right = recursive_tree(to_work, mid + 1, last)
    root
  end

  def recursive_tree(array, start, last)
    p to_work = array
    if start > last
      return nil
    end
  # p start, last, mid
   p mid = (start + last) / 2
    root = Node.new(mid)
    p "this is start: #{start}, this is last #{last}, this is mid #{mid}"
    root.left = recursive_tree(to_work, start, mid - 1)
    root.right = recursive_tree(to_work, mid + 1, last)
    root
  end
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
 

end

tree = Tree.new([1,2,3,4,5,6,7,9,9,9,8])
p tree.pretty_print
