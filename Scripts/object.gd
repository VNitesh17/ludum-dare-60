extends CharacterBody2D

@export var speed: float = 100.0

var dir = [-1, 1].pick_random()
var count = 0

func _physics_process(delta: float) -> void:
	
	var direction = Vector2.ZERO
	direction.x = dir
	
	count+=1
	
	direction = direction.normalized()
	velocity = direction * speed
	
	if count >= 10:
		dir = [-1, 1].pick_random()
		count = 0
	
	move_and_slide()
	
	
