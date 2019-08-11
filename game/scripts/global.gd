class_name Global

const CHUNK_SIZE = Vector2(16, 16) # size of a chunk in cells
const CELL_SIZE = Vector2(16, 16)

class CardinalDirections:
	const NORTH = Vector2(0, -1)
	const EAST  = Vector2(1, 0)
	const SOUTH = Vector2(0, 1)
	const WEST  = Vector2(-1, 0)
	
	const MAIN = [NORTH, EAST, SOUTH, WEST]

static func random_chunk_cell():
	return Vector2(randi() % int(CHUNK_SIZE.x), randi() % int(CHUNK_SIZE.y))
