
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var step_size: float = 48.0
@export var move_speed: float = 180.0

var target_position: Vector2
var is_moving: bool = false

func _ready() -> void:
	target_position = position

func _process(delta: float) -> void:
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
			target_position += direction * step_size
			is_moving = true

	if is_moving:
		position = position.move_toward(target_position, move_speed * delta)

		if position.distance_to(target_position) < 1.0:
			position = target_position
			is_moving = false
