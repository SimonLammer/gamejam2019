extends Node2D

const CHUNKS_TO_LOAD = 4 # chunks to load in each direction of the player
onready var START_CHUNK_TILEMAP = $Chunks/Start/TileMap
onready var CHUNKS = {
	Vector2(0, 0): $Chunks/Start
}

var Global = preload("res://scripts/global.gd")
var land1 = preload("res://scenes/chunks/land/Land-1.tscn")

onready var player : Node2D = $Player
var direction = Vector2(0, 0)

func _ready():
	load_chunks_around_player()

func load_chunks_around_player():
	var pos = player.global_position
	var player_chunk = world_to_chunk(pos)
	for x in range(-CHUNKS_TO_LOAD, CHUNKS_TO_LOAD + 1):
		for y in range(-CHUNKS_TO_LOAD, CHUNKS_TO_LOAD + 1):
			var offset = Vector2(x, y)
			var chunk_pos = player_chunk + offset
			if not CHUNKS.has(chunk_pos):
				var valid_chunks = find_valid_chunks(chunk_pos)
				var new_chunk : Node2D = valid_chunks[0].instance() # TODO: choose chunk intelligently
				new_chunk.position = chunk_to_world(chunk_pos)
				$Chunks.add_child(new_chunk)
				CHUNKS[chunk_pos] = new_chunk

func _process(delta):
	player.translate(direction * delta * 150)
	load_chunks_around_player()

func find_valid_chunks(pos):
	return [land1] # TODO: ask nearby chunks for valid neighbors

func world_to_chunk(pos: Vector2):
	return START_CHUNK_TILEMAP.world_to_map(Vector2(
		int(pos.x / Global.CHUNK_SIZE.x),
		int(pos.y / Global.CHUNK_SIZE.y)
	))

func chunk_to_world(pos: Vector2):
	return START_CHUNK_TILEMAP.map_to_world(Vector2(
		pos.x * Global.CHUNK_SIZE.x,
		pos.y * Global.CHUNK_SIZE.y
	), true)
