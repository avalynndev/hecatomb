extends Node

var current_lev: int = 1
var change_level: bool = false
var player_health: int = 5
var player_speed: int = 400

func apply_sacrifice(id: String) -> void:
	match id:
		"health":
			player_health -= 1
			print("Sacrificed health. Now:", player_health)
		"speed":
			player_speed -= 20
			print("Sacrificed speed. Now:", player_speed)
		_:
			print("Unknown sacrifice:", id)
