extends Node2D

@export var level_number: int = 1
@export var leveltochange: PackedScene
@export var sacrificedialogue : DialogueResource

var level_cleared := false
var current_lev: int = 1
var change_level: bool = false
var player_health: int = 5
var player_speed: int = 400
var knowledge_sacrificed : bool = false
var player_dead : bool = false


signal player_won()
signal lose_knowledge()
signal lose_health()
signal lose_speed()
signal lose_shoot_speed()

func _ready() -> void:
	current_lev = level_number
	change_level = false

func _process(_delta: float) -> void:
	if not level_cleared:
		var enemies = get_tree().get_nodes_in_group("Enemy")
		if enemies.is_empty() and not change_level:
			level_cleared = true 
			change_level_after_delay()

func change_level_after_delay() -> void:
	change_level = true
	await get_tree().create_timer(0.0).timeout
	get_tree().paused = false
	current_lev += 1
	if leveltochange:
		emit_signal("player_won")
		DialogueManager.show_example_dialogue_balloon(sacrificedialogue, "start")

func sac_knowledge():
	emit_signal("lose_knowledge")

func sac_health():
	emit_signal("lose_health")

func sac_speed():
	emit_signal("lose_speed")
	
func sac_shoot_speed():
	emit_signal("lose_shoot_speed")

func _finished():
	get_tree().change_scene_to_packed(leveltochange)
