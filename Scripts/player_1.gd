extends CharacterBody2D
class_name Player

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@export var speed = 400
@export var BULLET : PackedScene

var direction = 0
var heartslist : Array[TextureRect]
var playerhealth : int = 5

func  _ready() -> void:
	var hearts_parent = $Health/Lives/Panel/HBoxContainer
	for child in hearts_parent.get_children():
		heartslist.append(child)
	print(heartslist)
	

func  _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = BULLET.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = global_position
		bullet.rotation = rotation


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if Input.is_action_pressed("left"):
		direction = -1
	elif Input.is_action_pressed("right"):
		direction = 1

func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	move_and_slide()
	
func _takeDamage(amount: int) -> void:
	if amount > 0:
		playerhealth -= amount
		anim_player.play("death")
		update_hearts_display()
		
		if playerhealth <= 0:
			print("Player shot and died.")
			get_tree().paused = true
			update_hearts_display()

func  update_hearts_display():
	for i in range(heartslist.size()):
		heartslist[i].visible = i < playerhealth
