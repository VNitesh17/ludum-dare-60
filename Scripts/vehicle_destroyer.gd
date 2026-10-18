extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Vehicles"):
		body.queue_free()
		print("destroyed vehicle " + body.name)
		
