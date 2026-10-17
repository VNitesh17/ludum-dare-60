extends Node2D

@export var object_scenes: Array[PackedScene] = []
@export var spawn_interval: float = 2.0

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_object)
	timer.autostart = true
	add_child(timer)

func spawn_object() -> void:
	if object_scenes.is_empty():
		return

	# Pick a random scene from the list
	var random_index = randi_range(0, object_scenes.size() - 1)
	var chosen_scene = object_scenes[random_index]

	if chosen_scene == null:
		return

	# Create the chosen object
	var instance = chosen_scene.instantiate()
	get_tree().current_scene.add_child(instance)

	# Spawn at this spawner's position
	instance.global_position = global_position
