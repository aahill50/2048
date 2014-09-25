require_relative 'tile'

class Board

	attr_accessor :rows

	def initialize(setup = true, rows = Array.new(4) {Array.new(4)})
		@rows = rows
		setup_board(setup)
		@move_history = []
	end

	def [](pos)
		x,y = pos
		self.rows[x][y]
	end

	def []=(pos, value)
		x,y = pos
		self.rows[x][y] = value
	end


	def setup_board(setup)
		(0..3).each do |row|
			(0..3).each do |col|
				pos = [row, col]
				self[pos] = nil
			end
		end
	end

	def self.rand_pos
		[rand(4), rand(4)]
	end

	def empty?(pos)
		self[pos].nil?
	end

	def all_tiles
		self.rows.flatten.compact
	end

	def place_random_tile
		pos = Board.rand_pos
		until self.empty?(pos)
			pos = Board.rand_pos
		end

		new_tile = Tile.new(pos)
		self[pos] = new_tile

	end

	def slide(dir, board = self)
		#Need to check direction of slide to ensure
			#that we iterate through tiles in the correct order
		case dir
		when :left, :up
			all_tiles.each { |tile| tile.slide(dir, board) }
		when :right, :down
			all_tiles.reverse.each { |tile| tile.slide(dir, board) }
		else
			raise "not a valid direction"
		end
	end

	def render
		render_string = ""

		(0..3).each do |row|
			(0..3).each do |col|
				pos = [row, col]
				render_string += self.empty?(pos) ? " _ " : self[pos].draw
			end
			render_string += "\n\n"
		end

		render_string
	end

	def draw
		puts render
		puts
	end
end

# b = Board.new
# b.place_random_tile
# b.place_random_tile
# b.place_random_tile
# b.place_random_tile
# b.place_random_tile
# b.place_random_tile
# b.place_random_tile

# b.draw
# # b.place_random_tile
# # b.draw
# # b.place_random_tile
# # b.draw
# b.slide(:right, b)
# b.draw

# b.slide(:right, b)
# b.draw

# b.slide(:up, b)
# b.draw
# # puts
# # b.slide(:left, b)
# # puts
# # b.slide(:down, b)
# # puts
# # b.slide(:up	, b)