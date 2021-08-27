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
        moves.each do |move|
            moves.delete(move) if @considered_positions.include?(move)
        end
        @considered_positions += moves
        return moves
    end

    def build_move_tree()
        tree = PolyTreeNode.new(@starting_position)
        arr = [tree]
        until arr.empty?
            node = arr.shift
            #return node if node.value == target_position
            new_move_positions(node.value).each do |move|
                new_child = PolyTreeNode.new(move)
                node.add_child(new_child)
            end
            arr += node.children
        end
        tree
    end
## input [0,0] --> [3,3]
## tree.value == [[0,0]] start
## child.value == tree.value + [move] == [[0,0], [1,2]]
## target value == child.value[-1]
## return child.value
## input [0,0] --> [[0,0] , [1,2] , [3,3]]

end
