extends Button

@export var options_path: String = "res://scenes/Options.tscn"

func _pressed() -> void:
	var err = get_tree().change_scene_to_file(options_path)
	if err != OK:
		push_error("Failed to change to Options scene: %s" % options_path)
