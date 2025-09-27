extends Node2D

@export var level_number: int = 1
@export var leveltochange: PackedScene

var level_cleared := false

func _ready() -> void:
	GlobalManager.current_lev = level_number
	GlobalManager.change_level = false

func _process(_delta: float) -> void:
	if not level_cleared:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		if enemies.is_empty() and not GlobalManager.change_level:
			level_cleared = true  # prevent re-trigger
			change_level_after_delay()

func change_level_after_delay() -> void:
	GlobalManager.change_level = true
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	GlobalManager.current_lev += 1
	print("Changing to level:", GlobalManager.current_lev)
	if leveltochange:
		get_tree().change_scene_to_packed(leveltochange)
	else:
		print("No next level assigned!")
