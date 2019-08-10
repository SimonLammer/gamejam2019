tool
extends Node2D

class_name Chunk

var Global = preload("res://scripts/global.gd")

export(bool) var _draw_bounds = true

func _ready():
	pass

func _draw():
	if Engine.editor_hint && _draw_bounds:
		var max_x = Global.CELL_SIZE.x * Global.CHUNK_SIZE.x
		var max_y = Global.CELL_SIZE.y * Global.CHUNK_SIZE.y
		var half_width=1
		var points = [
			Vector2(-half_width, -half_width),
			Vector2(-half_width, max_y + half_width),
			Vector2(max_x + half_width, max_y + half_width),
			Vector2(max_x + half_width, 0 - half_width),
			Vector2(0 - half_width, 0 - half_width)
		];
		for i in range(1, len(points)):
			draw_line(points[i-1], points[i], Color.red, 3)

func get_valid_neighbors(direction: Vector2):
	return [] # override in concrete class
