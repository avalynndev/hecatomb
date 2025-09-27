extends Node2D

@export var leveltochange : PackedScene

func _ready() -> void:
	GlobalManager.current_lev = 2

func  _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if enemies.is_empty() and GlobalManager.change_level == false:
		await get_tree().create_timer(3.0).timeout
		get_tree().paused = false
		GlobalManager.current_lev += 1
		GlobalManager.change_level = true
		print(GlobalManager.current_lev)
		get_tree().change_scene_to_packed(leveltochange)
