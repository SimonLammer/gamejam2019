tool
extends Chunk

class_name Dirt

func get_valid_neighbors(direction: Vector2):
	return [
		"dirt/dirt1",
		"dirt/dirt2",
	] # override in concrete class
