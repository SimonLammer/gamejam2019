tool
extends Node2D

var Global = preload("res://scripts/global.gd")

export(bool) var _draw_bounds = true setget init

func init(val):
	_draw_bounds = val

func _ready():
	pass

func _draw():
	if _draw_bounds && Engine.editor_hint:
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
