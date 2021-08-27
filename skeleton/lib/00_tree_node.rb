class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        parent = node
        node.children << self if parent != nil && node.children.include?(self)
        node.children.delete(self)
    end
end