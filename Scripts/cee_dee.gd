extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 300.0

var isDead = false

func _physics_process(delta: float) -> void:
	
	if isDead:
		return
	
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")

	direction = direction.normalized()
	
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

	velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Vehicles"):
		animated_sprite.play("dead")
		isDead = true
