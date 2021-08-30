require "byebug"

require_relative "poly_tree_node.rb"
class KnightPathFinder
    def initialize(starting_position)
        @starting_position = starting_position
        @considered_positions = [starting_position]
    end

    def self.valid_moves(pos)
        possible_moves = [[1,2], [-1,2], [-1,-2], [1, -2], [2,1], [-2, 1], [-2, -1], [2, -1]]
        moves = []
        possible_moves.each do |move|
            x = pos[0] + move[0]
            y = pos[1] + move[1]
            moves << [x, y] if x >= 0 && x < 8 && y >= 0 && y < 8
        end
        return moves
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        confirmed_moves = []
        moves.each do |move|
            confirmed_moves << move unless @considered_positions.include?(move)
        end
        @considered_positions += confirmed_moves
        return confirmed_moves
    end

    def build_move_tree()
        root = PolyTreeNode.new(@starting_position)
        arr = [root]
        until arr.empty?
            node = arr.shift
            new_move_positions(node.value).each do |move|
                new_child = PolyTreeNode.new(move)
                node.add_child(new_child)
            end
            arr += node.children
        end
        root
    end

    def find_path(end_pos)
        root = self.build_move_tree
        end_node = root.dfs(end_pos)
        end_node
    end

    def trace_path_back(node)
        nodes = []
        curr_pos = node.value
        until curr_pos == nil
            nodes.unshift(curr_pos)
            curr_pos = node.parent.value
        end
        return nodes
    end
end
