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
        node.parent = nil
        raise "not a child node" unless node.parent.include?(node)
    end
end