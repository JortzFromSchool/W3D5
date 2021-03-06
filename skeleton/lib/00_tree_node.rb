class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        @parent.children.delete(self) unless @parent == nil
        @parent = node
        @parent.children << self unless node == nil 
    end

    def add_child(node)
        node.parent = self
        self.children << node unless self.children.include?(node)
    end

    def remove_child(node)
        raise "not a child node" unless self.children.include?(node)
        node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            var = child.dfs(target_value) 
            return var unless var == nil
        end
        return nil
    end

    def bfs(target_value)
        arr = [self]
        until arr.empty?
            node = arr.shift
            return node if node.value == target_value
            arr += node.children
        end
        return nil 
    end

end

# class Searchable

    
# end