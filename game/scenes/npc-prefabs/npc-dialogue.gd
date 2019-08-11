extends Node

var dialog
export (String) var dialogFile

const DialogueUtils = preload("res://scripts/dialogue_utils.gd")
onready var utils = DialogueUtils.new()

func _ready():
	dialog = utils.load_file_as_JSON(dialogFile)
	print(dialog)