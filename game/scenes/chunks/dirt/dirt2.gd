tool
extends Dirt

onready var background = $Background
onready var foreground = $Foreground

const MIN_SPOTS = 2
const MAX_SPOTS = 9

const MAX_TREES = 13

func _ready():
	for i in range(randi() % (MAX_SPOTS - MIN_SPOTS) + MIN_SPOTS):
		var pos = Global.random_chunk_cell()
		background.set_cell(pos.x, pos.y, 8, false, false, false, Vector2(9, 2))
		
	for i in range(randi() % MAX_TREES):
		var pos = Global.random_chunk_cell()
		var x = TileMap.INVALID_CELL
		if pos.y > 0 \
			and foreground.get_cellv(pos) == TileMap.INVALID_CELL \
			and foreground.get_cellv(pos + Global.CardinalDirections.NORTH) == TileMap.INVALID_CELL:
			var tree = 10 + 2 * (randi() % 5)
			foreground.set_cellv(pos, tree)
			foreground.set_cellv(pos + Global.CardinalDirections.NORTH, tree + 1)
