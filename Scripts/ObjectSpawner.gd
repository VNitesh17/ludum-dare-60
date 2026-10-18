extends Area2D

@export var object_scene: PackedScene

var can_spawn: bool = true

func _process(_delta: float) -> void:
	if can_spawn:
		spawn_object()
		can_spawn = false

func spawn_object() -> void:
	var obj = object_scene.instantiate()
	get_tree().current_scene.add_child(obj)

	var collision_shape = $CollisionShape2D
	var shape = collision_shape.shape

	if shape is RectangleShape2D:
		var half_size = shape.size / 2.0

		var random_point = Vector2(
			randf_range(-half_size.x, half_size.x),
			randf_range(-half_size.y, half_size.y)
		)

		obj.global_position = collision_shape.to_global(random_point)
