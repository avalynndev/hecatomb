extends Button

@export var level1_path: String = "res://Scenes/Level 1.tscn"

func _pressed() -> void:
	var err = get_tree().change_scene_to_file(level1_path)
	if err != OK:
		push_error("Failed to change to Level1 scene: %s" % level1_path)
