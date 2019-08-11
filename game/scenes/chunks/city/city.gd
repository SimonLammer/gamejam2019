tool
extends Chunk

class_name City

func get_valid_neighbors(direction: Vector2):
	return [
		"city/city1",
		"city/city2",
		"dirt/dirt1",
	] # override in concrete class
