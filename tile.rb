require_relative 'board'

class Tile

	attr_accessor :value, :pos

	def initialize(pos, value = 2)
		@pos = pos
		@value = value
	end

	def slide(dir, board)
		next_pos = pos_to(dir)
		return if self.pos.nil?
		return if !on_board?(next_pos)

		neighbor = board[next_pos]

		if board.empty?(next_pos)
			board[self.pos], board[next_pos] = nil, self
			self.pos = next_pos
			
			#Need to fix slide to cover empty space
			# self.slide(dir, board) if board.empty?(next_pos)
		elsif self.can_combine?(neighbor)
			neighbor.value += self.value
			board[pos] = nil
			self.pos = nil
			self.value = nil
			# return nil
		else
			# return nil
		end
	end

	def on_board?(pos)
		pos.all? {|coord| coord.between?(0,3)}
	end

	def can_combine?(other_tile)
		self.value == other_tile.value
	end

	def pos_to(dir)
		x,y = self.pos
		case dir
		when :left
			[x, y-1]
		when :right
			[x, y+1]
		when :up
			[x-1, y]
		when :down
			[x+1, y]
		else
			raise "not a valid direction"
		end
	end

	def draw
		" #{self.value.to_s} "
	end

end