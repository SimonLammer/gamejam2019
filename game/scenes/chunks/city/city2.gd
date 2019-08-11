tool extends City

func _ready():
	$NPCSystem.create_npc("guy", global_position + $Background.map_to_world(Vector2(11, 6), false))
