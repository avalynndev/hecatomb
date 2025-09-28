extends Node2D

@export var level_number: int = 1
@export var leveltochange: PackedScene
@export var sacrificedialogue : String

var level_cleared := false
var current_lev: int = 1
var change_level: bool = false
var player_health: int = 5
var player_speed: int = 400

signal  player_won()

func _ready() -> void:
	current_lev = level_number
	change_level = false

func _process(_delta: float) -> void:
	if not level_cleared:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		if enemies.is_empty() and not change_level:
			level_cleared = true  # prevent re-trigger
			change_level_after_delay()

func change_level_after_delay() -> void:
	change_level = true
	await get_tree().create_timer(.0).timeout
	get_tree().paused = false
	current_lev += 1
	print("Changing to level:", current_lev)
	if leveltochange:
		emit_signal("player_won")
		DialogueManager.show_example_dialogue_balloon(load(sacrificedialogue), "start")
	else:
		print("No next level assigned!")
		
func _finished():
	print("finished")
	get_tree().change_scene_to_packed(leveltochange)
	
