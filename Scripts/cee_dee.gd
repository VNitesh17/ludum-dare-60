
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var step_size: float = 64.0
@export var move_speed: float = 300.0

var target_position: Vector2
var is_moving: bool = false

func _ready() -> void:
	target_position = position
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if not is_moving:
		var direction := Vector2.ZERO

		if Input.is_action_just_pressed("move_up"):
			direction = Vector2.UP
		elif Input.is_action_just_pressed("move_down"):
			direction = Vector2.DOWN
		elif Input.is_action_just_pressed("move_left"):
			direction = Vector2.LEFT
			animated_sprite.flip_h = true
		elif Input.is_action_just_pressed("move_right"):
			direction = Vector2.RIGHT
			animated_sprite.flip_h = false
			

		if direction != Vector2.ZERO:
			var next_position := target_position + direction * step_size
			target_position = next_position
			is_moving = true
			

	if is_moving:
		global_position = global_position.move_toward(
			target_position + get_parent().global_position,
			move_speed * delta
		)

		if global_position.distance_to(
			target_position + get_parent().global_position
		) < 1.0:
			global_position = target_position + get_parent().global_position
			is_moving = false
