extends Node2D

const CHUNKS_TO_LOAD = 4 # chunks to load in each direction of the player
onready var START_CHUNK_TILEMAP = $Chunks/Start/TileMap
onready var CHUNKS = {
	Vector2(0, 0): $Chunks/Start
}

var Global = preload("res://scripts/global.gd")

const CHUNK_CLASSES_BASE_PATH = "res://scenes/chunks/"
const CHUNK_CLASSES_PATHS = [
	"land/land-1",
	"land/land-2",
]
const CHUNK_CLASSES_EXTENSION = ".tscn"
var CHUNK_CLASSES = {} # example entry: "land/land-1": preload("res://scenes/chunks/land/land-1.tscn")
var DEFAULT_CHUNK_CLASS

export (Vector2) var playerPosition = Vector2() setget _set_player_position

func _set_player_position(value):
	playerPosition = value
	load_chunks_around_player()

func _ready():
	randomize()
	load_chunk_classes(CHUNK_CLASSES_PATHS)
	load_chunks_around_player()

func load_chunk_classes(paths):
	var dict = {}
	for path in paths:
		var loaded = load(CHUNK_CLASSES_BASE_PATH + path + CHUNK_CLASSES_EXTENSION)
		if dict.empty():
			DEFAULT_CHUNK_CLASS = loaded
		dict[path] = loaded
	CHUNK_CLASSES = dict

func load_chunks_around_player():
	var pos = playerPosition
	var player_chunk = world_to_chunk(pos)
	for x in range(-CHUNKS_TO_LOAD, CHUNKS_TO_LOAD + 1):
		for y in range(-CHUNKS_TO_LOAD, CHUNKS_TO_LOAD + 1):
			var offset = Vector2(x, y)
			var chunk_pos = player_chunk + offset
			load_chunk(chunk_pos)

func load_chunk(pos):
	if not CHUNKS.has(pos):
		var valid_chunks = find_valid_chunks(pos)
		var new_chunk : Chunk = valid_chunks[randi() % len(valid_chunks)].instance() # TODO: choose chunk intelligently
		new_chunk.position = chunk_to_world(pos)
		$Chunks.add_child(new_chunk)
		CHUNKS[pos] = new_chunk

func find_valid_chunks(pos):
	var valid_chunks_collections = []
	for direction in Global.CardinalDirections.MAIN:
		var neighbor_position = pos + direction
		var neighbor : Chunk = CHUNKS.get(neighbor_position)
		if neighbor:
			valid_chunks_collections.append((neighbor as Chunk).get_valid_neighbors(direction))
	if valid_chunks_collections:
		var choices = valid_chunks_collections[0]
		for i in range(1, len(valid_chunks_collections)):
			for j in range(len(choices) - 1, 0, -1):
				if not valid_chunks_collections[i].has(choices[j]):
					choices.remove(j)
		if choices.empty():
			print("ERROR: no valid chunk found")
			for direction in Global.CardinalDirections.MAIN:
				var chunk = CHUNKS.get(pos + direction)
				print(direction, " -> ", chunk.filename if chunk else "null")
			assert(false)
		for i in range(len(choices)):
			choices[i] = CHUNK_CLASSES[choices[i]]
		return choices
	else:
		return [DEFAULT_CHUNK_CLASS] # TODO: ask nearby chunks for valid neighbors

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
