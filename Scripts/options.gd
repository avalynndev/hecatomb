extends Control
const BALLOON = preload("res://Dialogues/StorylineButton.tscn")

func _ready() -> void:
	var balloon = BALLOON.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(load("res://Dialogues/Storyline.dialogue"), "start")
