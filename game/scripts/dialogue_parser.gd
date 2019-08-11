extends Node

var ui
var dialog
var currentNode
var nextNode
var choices
var target

signal dialogue_finished

func get_choices(dialog_node):
	var choices = []
	for obj in dialog_node:
		if obj.q != null:
			choices.append(obj.q)
	return choices

func init_dialogue(target):
	
	self.target = target
	
	if !target.has_node("DialogueConfig") || target.get_node("DialogueConfig").get("dialog") == null:
		emit_signal("dialogue_finished", target)
		print("target has no dialogue configured")
		return
	
	var node = target.get_node("DialogueConfig")
	dialog = node.dialog
	
	currentNode = dialog["start"]
	show_choices_for_current_node()
	
func on_dialog_choice(i):
	print("dialog choice")
	var selectedChoice = currentNode[i]
	if selectedChoice.get("next") != null:
		nextNode = dialog[selectedChoice.next]
	else:
		nextNode = null
		
	ui.connect("dialogue_continue", self, "on_next_dialog", [], CONNECT_ONESHOT)
	ui.show_dialogue_text(selectedChoice.a)
		
		# TODO: effects
func on_next_dialog():
	if nextNode != null:
		currentNode = nextNode
		nextNode = null
		show_choices_for_current_node()
	else:
		end_dialogue()
		
func show_choices_for_current_node():
	choices = get_choices(currentNode)
	ui.connect("dialogue_choice", self, "on_dialog_choice", [], CONNECT_ONESHOT)
	ui.show_dialogue_choices(choices)
	
func end_dialogue():
	ui.end_dialogue()
	emit_signal("dialogue_finished", target)
	
func _ready():
	ui = get_node("../CanvasLayer/")
	