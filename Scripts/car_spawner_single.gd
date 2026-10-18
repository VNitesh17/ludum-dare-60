extends Node2D

@export var object_scenes: Array[PackedScene] = []

var can_spawn: bool = true

func _process(_delta: float) -> void:
	if can_spawn:
		spawn_object()
		can_spawn = false

func spawn_object() -> void:
	if object_scenes.is_empty():
		return

	var random_index = randi_range(0, object_scenes.size() - 1)
	var chosen_scene = object_scenes[random_index]

	if chosen_scene == null:
		return

	var instance = chosen_scene.instantiate()
	get_tree().current_scene.add_child(instance)

	instance.global_position = global_position
