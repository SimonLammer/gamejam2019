class Interaction:
	var nodeA: Node2D
	var nodeB: Node2D
	var distance: int
	var action
	var hint: String
	
	func _init(nodeA, nodeB, distance, action, hint):
		self.nodeA = nodeA
		self.nodeB = nodeB
		self.distance = distance
		self.action = action
		self.hint = hint if hint != null else ""

class InteractionManager:
	var uiManager
	var interactions: Array
	
	func _init(uiManager):
		self.uiManager = uiManager
		interactions = []
		
	func add_interaction(nodeA: Node2D,
		nodeB: Node2D,
		distance: int,
		action,
		hint: String = ""):
		var interaction = Interaction.new(nodeA, nodeB, distance, action, hint)
		
		interactions.append(interaction)
		
	func check_interactions():
		
		uiManager.clear_hint()
		for interaction in interactions:
			var nodeA = interaction.nodeA
			var nodeB = interaction.nodeB
		
			if ((nodeA.global_position
				- nodeB.global_position).length_squared()
					< interaction.distance):
				uiManager.show_hint(interaction.hint)
				if Input.is_action_just_pressed('interact'):
					interaction.action(nodeA, nodeB)
