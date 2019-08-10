tool
extends Node2D

var CELL_SIZE = Vector2(30, 30)
var CHUNK_SIZE = Vector2(8, 8)

export(bool) var _draw_bounds = true setget init

func init(val):
	_draw_bounds = val

func _ready():
	print("READY")
	pass

func _draw():
	if _draw_bounds && Engine.editor_hint:
		var max_x = CELL_SIZE.x * CHUNK_SIZE.x
		var max_y = CELL_SIZE.y * CHUNK_SIZE.y
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
