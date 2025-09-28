extends Area2D

var speed: int = 500

func  _ready() -> void:
		GlobalManager.lose_shoot_speed.connect(_on_lose_shoot_speed)

func _process(delta: float) -> void:

	position += transform.x * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		var collider = body
		collider._takeDamage(1)
		queue_free()
	elif body is TileMapLayer:
		queue_free()

func _on_lose_shoot_speed():
	speed = 210
