tool
extends Chunk

func _ready():
	pass

func get_valid_neighbors(direction: Vector2):
	return [
		"land/land-1",
		"land/land-2",
	]
