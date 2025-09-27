extends CharacterBody2D
class_name Player

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var speed: int = 400
@export var BULLET: PackedScene

var direction: int = 0
var heartslist: Array = []
var playerhealth: int = 5

func _ready() -> void:
	# Pull health from GlobalManager (autoload)
	playerhealth = GlobalManager.player_health
	print("Loaded health:", playerhealth)
	
	if GlobalManager.player_health <= 0:
		GlobalManager.player_health = 4
	playerhealth = GlobalManager.player_health
	print("Loaded health:", playerhealth)

	# Collect all heart icons
	var hearts_parent = $Health/Lives/Panel/HBoxContainer
	heartslist.clear()
	for child in hearts_parent.get_children():
		if child.has_node("Sprite2D"):
			heartslist.append(child.get_node("Sprite2D"))
		elif child is Sprite2D:
			heartslist.append(child)
	print("Collected hearts:", heartslist.size())
	update_hearts_display()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and BULLET:
		var bullet = BULLET.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = global_position
		bullet.rotation = rotation

func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if Input.is_action_pressed("left"):
		direction = -1
	elif Input.is_action_pressed("right"):
		direction = 1

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	get_input()
	move_and_slide()

func _takeDamage(amount: int) -> void:
	if amount > 0:
		playerhealth -= amount
		GlobalManager.player_health = playerhealth  # update global
		anim_player.play("death")
		update_hearts_display()

		if playerhealth <= 0:
			print("Player shot and died.")
			await anim_player.animation_finished
			call_deferred("_go_to_game_over")

func _go_to_game_over() -> void:
	var tree := get_tree()
	if tree:
		tree.paused = false
		tree.change_scene_to_file("res://Scenes/GameOver.tscn")

func update_hearts_display() -> void:
	for i in range(heartslist.size()):
		heartslist[i].visible = i < playerhealth
