require 'byebug'
class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    parent.children.reject! {|child| child == self} if parent

    @parent = new_parent
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    children << child_node unless children.include?(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not a valid child" unless children.include?(child_node)
    children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if target_value == self.value
    children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      return queue[0] if queue[0].value == target_value
      queue += queue[0].children
      queue.shift
    end
    nil
  end

  def inspect
    {:value => @value, :parent => parent, :children => children.count }.inspect
  end
end
