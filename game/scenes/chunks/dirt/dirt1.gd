tool
extends Dirt

onready var tilemap = $TileMap

const MIN_SPOTS = 4
const MAX_SPOTS = 14

func _ready():
	for i in range(randi() % (MAX_SPOTS - MIN_SPOTS) + MIN_SPOTS):
		var pos = Global.random_chunk_cell()
		tilemap.set_cell(pos.x, pos.y, 8, false, false, false, Vector2(9, 2))
